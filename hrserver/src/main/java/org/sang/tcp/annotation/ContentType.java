package org.sang.tcp.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.sang.tcp.service.SendMessageService;
import org.sang.tcp.service.impl.DefaultServiceImpl;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface ContentType {

    public byte[] type() default 0x10;

    /** 消息处理类 */
    public Class<? extends SendMessageService> bind() default DefaultServiceImpl.class;

}
