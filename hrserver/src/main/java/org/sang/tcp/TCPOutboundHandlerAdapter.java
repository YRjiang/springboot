/**
 *====================================================
 * 文件名称: FFCSDeviceNoticeServiceImpl.java
 * 修订记录：
 * No    日期				作者(操作:具体内容)
 * 1.    2018年10月23日			chenxy(创建:创建文件)
 *====================================================
 * 类描述：(说明未实现或其它不应生成javadoc的内容)
 */
package org.sang.tcp;

import org.sang.tcp.model.Message;
import org.sang.tcp.service.SendMessageService;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;

@Service
@ConditionalOnProperty(name = "newland.notice.type", havingValue = "ffcs")
public class TCPOutboundHandlerAdapter implements SendMessageService {

    /*@Override
    public void notice(Message message) {
        // do nothing
    }*/

    @Override
    public void handle(Message message) {
        // TODO Auto-generated method stub
        /*byte[] type = null;
        SendMessageService handler = ApplicationContextHelper
                .getBean(MessageCollector.createSendMessageElement(type).getSendMessageService());
        handler.handle(message);*/
    }

}
