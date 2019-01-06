package org.sang.tcp;

import java.util.Set;

import javax.annotation.PostConstruct;

import org.sang.tcp.annotation.ActionType;
import org.sang.tcp.annotation.ContentType;
import org.sang.tcp.common.ClassUtil;
import org.sang.tcp.model.Message;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class MessageBootstrap {

    @PostConstruct
    public void bootstrap() {
        try {
            Set<Class<? extends Message>> recvMessages = ClassUtil.getAllAssignedClass(Message.class,
                    "org.sang.tcp.model.receive");
            for (Class<? extends Message> cls : recvMessages) {
                ActionType actionType = cls.getAnnotation(ActionType.class);
                if (actionType != null) {
                    MessageCollector.putRecvMessageElement(actionType.action(), cls);
                }
            }

            Set<Class<? extends Message>> sendMessages = ClassUtil.getAllAssignedClass(Message.class,
                    "org.sang.tcp.model.send");///org.sang.tcp.model
            for (Class<? extends Message> cls : sendMessages) {
                ContentType contentType = cls.getAnnotation(ContentType.class);
                if (contentType != null) {
                    MessageCollector.putSendMessageElement(contentType.type(), cls);
                }
            }
        } catch (Exception e) {
            log.error("加载协议类型出错...", e);
        }
    }

}
