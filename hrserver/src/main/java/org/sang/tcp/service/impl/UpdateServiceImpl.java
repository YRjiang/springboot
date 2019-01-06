package org.sang.tcp.service.impl;

import org.sang.tcp.model.Message;
import org.sang.tcp.service.SendMessageService;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 处理update消息
 */
@Slf4j
@Service("updateService")
public class UpdateServiceImpl implements SendMessageService {

    /* @Value("${newland.amqp.address.sendout}")
    private String FFCS_MESSAGE_QUENE_SENDOUT;*/

    /*@Autowired
    private AmqpTemplate template;*/

    private ObjectMapper jackson = new ObjectMapper();

    @Override
    public void handle(Message message) {
        /*Heartbeat heartbeat = (Heartbeat) message.getBody().getContent();
        Update update = new Update();
        update.setAction(Constants.ACTION_TYPE_UPDATE);
        update.setDeviceId(heartbeat.getSn());
        int state = heartbeat.getState(); // 1：空闲，2：工作，3：故障
        int status = 3; // 1：离线，2：播放，3：待机
        switch (state) {
        	case 1: status = 3; break;
        	case 2: status = 2; break;
        	case 3: status = 1; break;
        }
        update.setStatus(status);
        
        String updateStr = "";
        try {
        	updateStr = jackson.writeValueAsString(update);
        } catch (JsonProcessingException e) {
        	logger.error("消息体转换json异常");
        }
        template.convertAndSend(FFCS_MESSAGE_QUENE_SENDOUT, updateStr);*/
    }

}
