package org.sang.tcp.common;

import java.io.IOException;
import java.util.concurrent.TimeoutException;

import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

public class ConnectionUtil {

    /*    @Value("${spring.rabbitmq.host}")
    private String host;
    @Value("${spring.rabbitmq.port}")
    private int port;
    @Value("${spring.rabbitmq.vhost}")
    private String vhost;
    @Value("${spring.rabbitmq.username}")
    private String username;
    @Value("${spring.rabbitmq.password}")
    private String password;*/

    public static Connection getConnection() throws IOException, TimeoutException {
        //1.定义连接工厂
        ConnectionFactory connectionFactory = new ConnectionFactory();
        //2.设置服务器地址
        connectionFactory.setHost("localhost");//host
        //3.设置端口
        connectionFactory.setPort(5672);//port
        //4.设置虚拟主机,用户名,密码
        connectionFactory.setVirtualHost("/");//vhost
        connectionFactory.setUsername("rabbitadmin");//username
        connectionFactory.setPassword("admin");//password

        //5.通过连接工厂获取连接
        Connection connection = connectionFactory.newConnection();
        return connection;
    }

}
