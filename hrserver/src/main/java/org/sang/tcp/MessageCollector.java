package org.sang.tcp;

import java.util.HashMap;
import java.util.Map;

import org.sang.tcp.model.Message;

public class MessageCollector {

    private static final Map<String, Class<? extends Message>> RECV_MESSAGE_ELEMENTS = new HashMap<>();

    private static final Map<byte[], Class<? extends Message>> SEND_MESSAGE_ELEMENTS = new HashMap<>();

    static void putRecvMessageElement(String action, Class<? extends Message> cls) {
        RECV_MESSAGE_ELEMENTS.put(action, cls);
    }

    static void putSendMessageElement(byte[] type, Class<? extends Message> cls) {
        SEND_MESSAGE_ELEMENTS.put(type, cls);
    }

    public static Message createRecvMessageElement(String action) {
        try {
            Class<? extends Message> cls = RECV_MESSAGE_ELEMENTS.get(action);
            if (cls == null) {
                throw new java.lang.IllegalArgumentException("未找到指令标识[" + action + "]的编码实现");
            }
            return cls.newInstance();
        } catch (Exception e) {
            throw new java.lang.IllegalArgumentException("指令标识[" + action + "]的编码实现初始化失败:" + e.getMessage());
        }
    }

    public static Message createSendMessageElement(byte[] type) {
        try {
            Class<? extends Message> cls = SEND_MESSAGE_ELEMENTS.get(type);
            if (cls == null) {
                throw new java.lang.IllegalArgumentException("未找到业务数据包类型[" + type + "]的编码实现");
            }
            return cls.newInstance();
        } catch (Exception e) {
            throw new java.lang.IllegalArgumentException("业务数据包类型[" + type + "]的编码实现初始化失败:" + e.getMessage());
        }
    }

}
