package org.sang.tcp.service.impl;

import org.sang.tcp.model.Message;
import org.sang.tcp.service.RecvMessageService;
import org.sang.tcp.service.SendMessageService;
import org.springframework.stereotype.Service;

@Service
public class DefaultServiceImpl implements RecvMessageService, SendMessageService {

    @Override
    public void handle(String message) {
        // TODO Auto-generated method stub
    }

    @Override
    public void handle(Message message) {
        // TODO Auto-generated method stub
    }

}
