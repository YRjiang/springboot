package org.sang.tcp.rabbitmq.fanout;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class FanoutBReceiver {

    private Logger logger = LoggerFactory.getLogger(FanoutBReceiver.class);

    @RabbitListener(queues = "fanout.b")
    public void process(String message) {
        logger.info(String.format("receive fanout b message: %s", message));
    }

}
