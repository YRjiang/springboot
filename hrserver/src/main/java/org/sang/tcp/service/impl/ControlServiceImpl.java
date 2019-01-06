package org.sang.tcp.service.impl;

import org.sang.tcp.service.RecvMessageService;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 处理control消息
 */
@Slf4j
@Service
public class ControlServiceImpl implements RecvMessageService {

    private final static String FFCS_CLOUD_PLATFORM_ID = "33501000000000101010101";

    /*@Autowired
    private DeviceService deviceService;
    
    @Autowired
    private DeviceChannelService deviceChannelService;*/

    private ObjectMapper jackson = new ObjectMapper();

    @Override
    public void handle(String message) {

        log.info(" ============ ControlServiceImpl ====================== ");

        /*try {
        	Control control = jackson.readValue(message, Control.class);
        	
        	for (Device device : control.getDevices()) {
        		com.newland.command.entity.Device terminal = deviceService.findBySN(device.getDeviceId());
        
        		IPMessage command = new IPMessage();
        		
        		IPHead head = new IPHead();
        		head.setDirection(1);
        //				head.setMagicNumber(magicNumber);
        		head.setSession(System.currentTimeMillis());
        		head.setSign(0);
        //				head.setVersion(version);
        		command.setHead(head);
        		
        		IPValidate validate = new IPValidate();
        //				validate.setCrc(crc);
        //				validate.setDate(new Date());
        //				validate.setSign(sign);
        //				validate.setSn(sn);
        		command.setValidate(validate);
        		
        		// 2018-11-08 liujf 没有开关机参数，暂时这样处理逻辑
        		DefaultVolume dv = new DefaultVolume();
        		if (control.getRun()) {
        			dv.setVolume(control.getVolume());
        		} else {
        			dv.setVolume(0); // 关机命令视为静音
        		}
        		
        		DeviceSetting setting = new DeviceSetting();
        		List<DefaultVolume> params = new ArrayList<DefaultVolume>();
        		params.add(dv);
        		setting.setParams(params);
        
        		IPBody body = new IPBody();
        		body.setNumber(1);
        		body.setSource(FFCS_CLOUD_PLATFORM_ID);
        		body.setTarget(new String[]{terminal.getEbrid23()});
        		body.setContent(setting);
        		command.setBody(body);
        		Future<Response> response = deviceChannelService.command(terminal.getIp(), terminal.getPort(), command);
        		//FIXME 暂时不处理结果
        	}
        	
        } catch (Exception e) {
        	logger.error("消息体转化异常");
        }*/
    }

}
