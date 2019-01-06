package org.sang.tcp.service;

import org.sang.tcp.model.Message;

public interface SendMessageService {

    public void handle(Message message);

}
