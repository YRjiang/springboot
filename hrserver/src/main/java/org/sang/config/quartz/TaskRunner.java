package org.sang.config.quartz;

import java.util.List;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.sang.bean.quartz.QuartzEntity;
import org.sang.bean.quartz.Result;
import org.sang.service.quartz.IJobService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.ApplicationArguments;
import org.springframework.boot.ApplicationRunner;
import org.springframework.stereotype.Component;

/**
 * 初始化一个测试Demo任务
 * 创建者 科帮网
 * 创建时间	2018年4月3日
 */
@Component
public class TaskRunner implements ApplicationRunner{
    
	private final static Logger LOGGER = LoggerFactory.getLogger(TaskRunner.class);
	
	@Autowired
    private IJobService jobService;
	@Autowired
    private Scheduler scheduler;
	
    @SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
    public void run(ApplicationArguments var) throws Exception{
    	Long count = jobService.listQuartzEntity(null);
    	if(count==0){
    		LOGGER.info("初始化测试任务");
    		QuartzEntity quartz = new QuartzEntity();
    		quartz.setJobName("test01");
    		quartz.setJobGroup("test");
    		quartz.setDescription("测试任务");
    		quartz.setJobClassName("org.sang.job.SecondQuartzJob");
    		quartz.setCronExpression("0/20 * * * * ?");
   	        Class cls = Class.forName(quartz.getJobClassName()) ;
   	        cls.newInstance();
   	        //构建job信息
   	        JobDetail job = JobBuilder.newJob(cls).withIdentity(quartz.getJobName(),
   	        		quartz.getJobGroup())
   	        		.withDescription(quartz.getDescription()).build();
   	        //添加JobDataMap数据
   	        job.getJobDataMap().put("itstyle", "科帮网欢迎你");        
   	        job.getJobDataMap().put("blog", "https://blog.52itstyle.com");        
		   	job.getJobDataMap().put("data", new String[]{"张三","李四"});  
   	        // 触发时间点
   	        CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(quartz.getCronExpression());
   	        Trigger trigger = TriggerBuilder.newTrigger().withIdentity("trigger"+quartz.getJobName(), quartz.getJobGroup())
   	                .startNow().withSchedule(cronScheduleBuilder).build();	
   	        //交由Scheduler安排触发
   	        scheduler.scheduleJob(job, trigger);
    	} 
//    	{
//    	    LOGGER.info("初始化测试任务 ----- 2222 !!!!");
//            QuartzEntity quartz = new QuartzEntity();
//            quartz.setJobName("test02");
//            quartz.setJobGroup("test");
//            quartz.setDescription("测试任务222");
//            quartz.setJobClassName("org.sang.job.ThirdQuartzJob");
//            quartz.setCronExpression("0/30 * * * * ?");
//            Class cls = Class.forName(quartz.getJobClassName()) ;
//            cls.newInstance();
//            //构建job信息
//            JobDetail job = JobBuilder.newJob(cls).withIdentity(quartz.getJobName(),
//                    quartz.getJobGroup())
//                    .withDescription(quartz.getDescription()).build();
//            //添加JobDataMap数据
//            job.getJobDataMap().put("itstyle", "科帮网欢迎你");        
//            job.getJobDataMap().put("blog", "https://blog.52itstyle.com");        
//            job.getJobDataMap().put("data", new String[]{"王五","刘六"});  
//            // 触发时间点
//            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(quartz.getCronExpression());
//            Trigger trigger = TriggerBuilder.newTrigger().withIdentity("trigger"+quartz.getJobName(), quartz.getJobGroup())
//                    .startNow().withSchedule(cronScheduleBuilder).build();  
//            //交由Scheduler安排触发
//            scheduler.scheduleJob(job, trigger);
//    	} 
/*    	{
    	    QuartzEntity quartz = new QuartzEntity();
            quartz.setJobName("test03");
            quartz.setJobGroup("test");
            quartz.setDescription("测试任务333");
            quartz.setJobClassName("org.sang.job.ChickenJob");
            quartz.setCronExpression("0/10 * * * * ?");
    	    save(quartz);
    	}*/
/*    	{
    	    list(null, 1, 10);
    	}*/
    	
    }
    
    public Result save(QuartzEntity quartz){
        LOGGER.info("新增任务");
        try {
            //如果是修改  展示旧的 任务
            if(quartz.getOldJobGroup()!=null){
                JobKey key = new JobKey(quartz.getOldJobName(),quartz.getOldJobGroup());
                scheduler.deleteJob(key);
            }
            Class cls = Class.forName(quartz.getJobClassName()) ;
            cls.newInstance();
            //构建job信息
            JobDetail job = JobBuilder.newJob(cls).withIdentity(quartz.getJobName(),
                    quartz.getJobGroup())
                    .withDescription(quartz.getDescription()).build();
            // 触发时间点
            CronScheduleBuilder cronScheduleBuilder = CronScheduleBuilder.cronSchedule(quartz.getCronExpression());
            Trigger trigger = TriggerBuilder.newTrigger().withIdentity("trigger"+quartz.getJobName(), quartz.getJobGroup())
                    .startNow().withSchedule(cronScheduleBuilder).build();  
            //交由Scheduler安排触发
            scheduler.scheduleJob(job, trigger);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error();
        }
        return Result.ok();
    }

    public Result list(QuartzEntity quartz, Integer pageNo, Integer pageSize){
        LOGGER.info("任务列表");
        List<QuartzEntity> list = jobService.listQuartzEntity(null, pageNo, pageSize);
        return Result.ok(list);
    }
    
}