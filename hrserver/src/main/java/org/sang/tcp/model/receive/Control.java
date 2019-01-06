package org.sang.tcp.model.receive;

import org.sang.tcp.annotation.ActionType;
import org.sang.tcp.model.Message;
import org.sang.tcp.service.impl.ControlServiceImpl;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@ActionType(action = "control", bind = ControlServiceImpl.class)
public class Control extends Message {

    //private String action;

    /**
     * 设备音量 （1-100）
     */

    private Integer volume;

    /**
     * 设备启动，false：关闭、true：启动
     */

    private Boolean run;

    /**
     * 任务关联的设备集合
     */
    //private List<Device> devices;

}
