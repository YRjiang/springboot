package org.sang.tcp.model;

import org.sang.tcp.annotation.ActionType;
import org.sang.tcp.service.RecvMessageService;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import lombok.Getter;
import lombok.Setter;

@JsonIgnoreProperties({ "recvMessageService", "sendMessageService" })
public class Message {

    /**
     * 指令标识
     */
    @Getter
    @Setter
    private String action;

    public Class<? extends RecvMessageService> getRecvMessageService() {
        ActionType actionType = this.getClass().getAnnotation(ActionType.class);
        Class<? extends RecvMessageService> recvMessageService = actionType.bind();
        return recvMessageService;
    }

    /*public Class<? extends SendMessageService> getSendMessageService() {
        ContentType contentType = this.getClass().getAnnotation(ContentType.class);
        Class<? extends SendMessageService> sendMessageService = contentType.bind();
        return sendMessageService;
    }*/

}
