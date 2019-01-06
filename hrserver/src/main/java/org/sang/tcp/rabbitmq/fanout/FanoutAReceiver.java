package org.sang.tcp.rabbitmq.fanout;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class FanoutAReceiver {

    private Logger logger = LoggerFactory.getLogger(FanoutAReceiver.class);

    @RabbitListener(queues = "fanout.a")
    public void process(String message) {
        logger.info(String.format("receive fanout a message: %s", message));
    }

}
