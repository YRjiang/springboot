package org.sang.tcp.rabbitmq.fanout;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class FanoutCReceiver {

    private Logger logger = LoggerFactory.getLogger(FanoutCReceiver.class);

    @RabbitListener(queues = "fanout.c")
    public void process(String message) {
        logger.info(String.format("receive fanout c message: %s", message));
    }

}
