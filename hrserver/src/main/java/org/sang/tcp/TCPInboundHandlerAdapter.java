package org.sang.tcp;

import org.sang.ApplicationContextHelper;
import org.sang.tcp.service.RecvMessageService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitHandler;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSONObject;

@Component
@RabbitListener(queues = "distribute")
public class TCPInboundHandlerAdapter {
    private Logger logger = LoggerFactory.getLogger(TCPInboundHandlerAdapter.class);

    private final static String COLUMN_ACTION = "action";

    /**  TcpInboundHandlerSender 发送 json字符串 消息到队列 distribute  **/
    //需要把java对象、json对象转成 json字符串;   {"name":"string", "sex":"string", "age":"int"}

    @RabbitHandler
    public void process(String message) {
        logger.info(String.format("receive message: %s", message));
        logger.info("distribute receiver ======================== ");

        decodeAndDispatch(message);//message -- json 字符串

    }

    /**
     * 预解析并且分发对应解析器
     * @param message
     */
    public void decodeAndDispatch(String payload) {
        try {
            JSONObject jsonObject = JSONObject.parseObject(payload);
            String action = jsonObject.getString(COLUMN_ACTION);
            try {
                RecvMessageService service = ApplicationContextHelper
                        .getBean(MessageCollector.createRecvMessageElement(action).getRecvMessageService());
                if (service != null) {
                    service.handle(payload);
                } else {
                    logger.error("消息体找不到对应处理器：" + payload);
                }
            } catch (Exception e) {
                logger.error("处理器处理消息时发生异常：" + payload);
            }
        } catch (Exception e) {
            logger.error("消息体格式不满足规范：" + payload);
        }
    }

}
