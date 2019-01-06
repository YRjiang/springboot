package org.sang.tcp.rabbitmq.object;

import org.sang.tcp.model.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class ObjectSender {

    private static Logger logger = LoggerFactory.getLogger(ObjectSender.class);

    @Autowired
    private AmqpTemplate rabbitTemplate;

    public void send(User user) {
        rabbitTemplate.convertAndSend("object", user);
        logger.info(String.format("send object: %s", user));
    }

}
