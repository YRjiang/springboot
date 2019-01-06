/**
 *====================================================
 * 文件名称: EmptyClientInboundServiceImpl.java
 * 修订记录：
 * No    日期				作者(操作:具体内容)
 * 1.    2018年10月23日			yr(创建:创建文件)
 *====================================================
 * 类描述：(说明未实现或其它不应生成javadoc的内容)
 */
package org.sang.tcp.service.impl;

import org.sang.tcp.service.ClientInboundService;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

/**
 * @ClassName: EmptyClientInboundServiceImpl
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author yr
 * @date 2018年10月23日 上午10:43:01
 */
@Slf4j
@Service
public class EmptyClientInboundServiceImpl implements ClientInboundService {

    @Override
    public void handler(String message) {// , InetSocketAddress remote
        // TODO Auto-generated method stub
        System.out.println("EmptyClientInboundServiceImpl");
        log.info("");
    }

}
