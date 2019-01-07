package org.sang.job;

import org.quartz.JobDataMap;
import org.quartz.JobExecutionException;
import org.sang.tcp.model.User;
import org.sang.tcp.model.receive.Control;
import org.sang.tcp.rabbitmq.direct.HelloSender;
import org.sang.tcp.rabbitmq.direct.TcpInboundHandlerSender;
import org.sang.tcp.rabbitmq.fanout.FanoutSender;
import org.sang.tcp.rabbitmq.object.ObjectSender;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;

/*
 * 相应的 废弃了 此 quartz 方案;
 * 
 */

@Component
public class SmsQuartzJob {
    private Logger logger = LoggerFactory.getLogger(SmsQuartzJob.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;

    @Autowired
    private ObjectSender objectSender;

    @Autowired
    private HelloSender helloSender;// rabbit 提供者接口
    @Autowired
    private FanoutSender fanoutSender;// rabbit 订阅者模式发送接口
    @Autowired
    private TcpInboundHandlerSender tcpInboundHandlerSender;

    public void loadComment(JobDataMap map) throws JobExecutionException {

        /*String jarPath = map.getString("jarPath");
        String parameter = map.getString("parameter");
        String vmParam = map.getString("vmParam");
        String icon = map.getString("icon");
        String name = map.getString("name");*/

        System.out.println(" ==== 定时任务开始 ==== ");
        //helloSender.send(" rabbit distribute ");// rabbit 最简单模式
        // fanoutSender.send("email");//rabbit 订阅模式

        User user = new User();
        user.setAction("action");
        user.setId(1L);
        user.setName("ConanLi");
        /*objectSender.send(user);*/

        Control control = new Control();
        control.setAction("control");
        control.setVolume(9);
        control.setRun(true);

        String str = JSON.toJSONString(control);//把 java对象转成 json字符串,方便 rabbitmq接收处 解析
        tcpInboundHandlerSender.send(str);//给 rabbitmq 发送消息

        /*if (name == "email") {
            logger.info("message job name : {} ", map.getString("name"));
            logger.info("message job description : " + map.getString("JobDescription"));
            logger.info("message job group: {} ", map.getString("group"));
            logger.info("message job cron : " + map.getString("cronExpression"));
            logger.info("message job jar path : {} ", jarPath);
            logger.info("message job parameter : {} ", parameter);
            logger.info("message job vmParam : {} ", vmParam);
            logger.info("message job iconCls : {} ", icon);
        
            System.out.println("任务执行 -----   message ");
        }*/
    }

}
