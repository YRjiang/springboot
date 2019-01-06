package org.sang.tcp.model.send;

import org.sang.tcp.annotation.ContentType;
import org.sang.tcp.model.Message;
import org.sang.tcp.service.impl.UpdateServiceImpl;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

@Data
@Accessors(chain = true)
@EqualsAndHashCode(callSuper = false)
@ContentType(type = { 0x10 }, bind = UpdateServiceImpl.class)
public class Update extends Message {

    /**
     * 设备id
     */
    @JsonProperty("device_id")
    private String deviceId;

    /**
     * 设备状态  1：离线，2：播放，3：待机
     */
    private Integer status;

}
