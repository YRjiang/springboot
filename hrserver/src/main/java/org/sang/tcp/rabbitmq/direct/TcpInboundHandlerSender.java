package org.sang.tcp.rabbitmq.direct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TcpInboundHandlerSender {

    private Logger logger = LoggerFactory.getLogger(TcpInboundHandlerSender.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;

    public void send(String string) {
        rabbitTemplate.convertAndSend("distribute", string);
        logger.info(String.format("send message: %s", string));
    }

}
