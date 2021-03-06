//package org.sang.job;
//
//import java.io.BufferedReader;
//import java.io.IOException;
//import java.io.InputStream;
//import java.io.InputStreamReader;
//
//import org.quartz.DisallowConcurrentExecution;
//import org.quartz.Job;
//import org.quartz.JobDataMap;
//import org.quartz.JobExecutionContext;
//import org.quartz.JobExecutionException;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Component;
//
///**
// * Created by EalenXie on 2018/6/4 14:29 
// * :@DisallowConcurrentExecution :
// * 此标记用在实现Job的类上面,意思是不允许并发执行.
// * :注意org.quartz.threadPool.threadCount线程池中线程的数量至少要多个,否则@DisallowConcurrentExecution不生效
// * :假如Job的设置时间间隔为3秒,但Job执行时间是5秒,设置@DisallowConcurrentExecution以后程序会等任务执行完毕以后再去执行,否则会在3秒时再启用新的线程执行
// */
//@DisallowConcurrentExecution
//@Component
//public class DynamicJob implements Job {
//    private Logger logger = LoggerFactory.getLogger(DynamicJob.class);
//
//    @Autowired
//    FirstQuartzJob firstQuartzJob;
//    @Autowired
//    SmsQuartzJob smsQuartzJob;
//
//    /**
//     * 核心方法,Quartz Job真正的执行逻辑.
//     * 
//     * @param executorContext
//     *            executorContext JobExecutionContext中封装有Quartz运行所需要的所有信息
//     * @throws JobExecutionException
//     *             execute()方法只允许抛出JobExecutionException异常
//     */
//    @Override
//    public void execute(JobExecutionContext executorContext) throws JobExecutionException {
//        // JobDetail中的JobDataMap是共用的,从getMergedJobDataMap获取的JobDataMap是全新的对象
//        JobDataMap map = executorContext.getMergedJobDataMap();
//        String jarPath = map.getString("jarPath");
//        String parameter = map.getString("parameter");
//        String vmParam = map.getString("vmParam");
//        String icon = map.getString("icon");
//
//        switch (map.getString("group")) {
//        case "helloworld":
//            //firstQuartzJob.loadComment(map);
//            break;
//        case "message":
//            smsQuartzJob.loadComment(map);
//            break;
//        default:
//            break;
//        }
//
//    }
//
//    // 记录Job执行内容
//    private void logProcess(InputStream inputStream, InputStream errorStream) throws IOException {
//        String inputLine;
//        String errorLine;
//        BufferedReader inputReader = new BufferedReader(new InputStreamReader(inputStream));
//        BufferedReader errorReader = new BufferedReader(new InputStreamReader(errorStream));
//        while ((inputLine = inputReader.readLine()) != null)
//            logger.info(inputLine);
//        while ((errorLine = errorReader.readLine()) != null)
//            logger.error(errorLine);
//    }
//
//}
