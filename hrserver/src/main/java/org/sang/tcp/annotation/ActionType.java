package org.sang.tcp.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.sang.tcp.service.RecvMessageService;
import org.sang.tcp.service.impl.DefaultServiceImpl;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface ActionType {

    public String action();

    public Class<? extends RecvMessageService> bind() default DefaultServiceImpl.class;

}
