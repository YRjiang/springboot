/**
 *====================================================
 * 文件名称: ClientInboundService.java
 * 修订记录：
 * No    日期				作者(操作:具体内容)
 * 1.    2018年10月23日			chenxy(创建:创建文件)
 *====================================================
 * 类描述：(说明未实现或其它不应生成javadoc的内容)
 */
package org.sang.tcp.service;

/**
 * @ClassName: ClientInboundService
 * @Description: TODO(这里用一句话描述这个类的作用)
 * @author chenxy
 * @date 2018年10月23日 上午10:30:58
 */
public interface ClientInboundService {

	public void handler(String message);// , InetSocketAddress remote

}
