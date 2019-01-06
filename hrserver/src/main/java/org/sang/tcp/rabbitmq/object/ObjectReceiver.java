package org.sang.tcp.rabbitmq.object;

import org.sang.tcp.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.rabbit.annotation.RabbitListener;
import org.springframework.stereotype.Component;

@Component
public class ObjectReceiver {

    private static Logger logger = LoggerFactory.getLogger(ObjectReceiver.class);

    @RabbitListener(queues = "object")
    public void process(User user) {
        logger.info(String.format("receive object: %s", user));
    }

}
