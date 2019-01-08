package org.sang.controller.quartz;


import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.quartz.CronScheduleBuilder;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.sang.bean.quartz.QuartzEntity;
import org.sang.bean.quartz.Result;
import org.sang.service.quartz.IJobService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/job")
public class QuartzJobController {
    private final static Logger LOGGER = LoggerFactory.getLogger(QuartzJobController.class);
    

    @Autowired
    private Scheduler scheduler;
    @Autowired
    private IJobService jobService;
    
    @SuppressWarnings({ "unchecked", "rawtypes" })
    @PostMapping("/add")
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
    
    @PostMapping("/list")
    public Object list(QuartzEntity quartz, @RequestParam(defaultValue = "1") Integer pageNo,
            @RequestParam(defaultValue = "10") Integer pageSize){
        LOGGER.info("任务列表");
        //QuartzEntity quartzEntity = new QuartzEntity();
        List<QuartzEntity> list = jobService.listQuartzEntity(quartz, pageNo, pageSize);
        return list;
    }
    
    @PostMapping("/trigger")
    public  Result trigger(QuartzEntity quartz,HttpServletResponse response) {
        LOGGER.info("触发任务");
        try {
             JobKey key = new JobKey(quartz.getJobName(),quartz.getJobGroup());
             scheduler.triggerJob(key);
        } catch (SchedulerException e) {
             e.printStackTrace();
             return Result.error();
        }
        return Result.ok();
    }
    
    @PostMapping("/pause")
    public  Result pause(QuartzEntity quartz,HttpServletResponse response) {
        LOGGER.info("停止任务");
        try {
             JobKey key = new JobKey(quartz.getJobName(),quartz.getJobGroup());
             scheduler.pauseJob(key);
        } catch (SchedulerException e) {
             e.printStackTrace();
             return Result.error();
        }
        return Result.ok();
    }
    
    @PostMapping("/resume")
    public  Result resume(QuartzEntity quartz,HttpServletResponse response) {
        LOGGER.info("恢复任务");
        try {
             JobKey key = new JobKey(quartz.getJobName(),quartz.getJobGroup());
             scheduler.resumeJob(key);
        } catch (SchedulerException e) {
             e.printStackTrace();
             return Result.error();
        }
        return Result.ok();
    }
    
    @PostMapping("/remove")
    public  Result remove(QuartzEntity quartz,HttpServletResponse response) {
        LOGGER.info("移除任务");
        try {  
            TriggerKey triggerKey = TriggerKey.triggerKey(quartz.getJobName(), quartz.getJobGroup());  
            // 停止触发器  
            scheduler.pauseTrigger(triggerKey);  
            // 移除触发器  
            scheduler.unscheduleJob(triggerKey);  
            // 删除任务  
            scheduler.deleteJob(JobKey.jobKey(quartz.getJobName(), quartz.getJobGroup()));  
            System.out.println("removeJob:"+JobKey.jobKey(quartz.getJobName()));  
        } catch (Exception e) {  
            e.printStackTrace();
            return Result.error();
        }  
        return Result.ok();
    }
}
