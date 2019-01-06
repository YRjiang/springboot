package org.sang.java;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;

/**
 * @Description Blob类型 数据存储入库、读取
 * @author []
 * @date 2018年12月18日 下午3:32:46
 */

public class QuartzTest {
    private static Logger logger = LoggerFactory.getLogger(QuartzTest.class);

    public static void getBlob() {//读取Blob数据
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = JDBCTools.getConnection();
            String sql = "SELECT * FROM qrtz_triggers WHERE TRIGGER_NAME = 'first'";
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                //int id = rs.getInt(1);
                /*String name = rs.getString(2);
                int age = rs.getInt(3);*/

                String SCHED_NAME = rs.getString(1);
                String TRIGGER_GROUP = rs.getString(3);
                String JOB_NAME = rs.getString(4);
                Blob JOB_DATA = rs.getBlob(16);
                logger.info("id: " + SCHED_NAME);
                logger.info("id: " + TRIGGER_GROUP);
                logger.info("JOB_NAME: " + JOB_NAME);
                logger.info("blob: " + JSONObject.toJSONString(JOB_DATA));

                /*Blob picture = rs.getBlob(4);//得到Blob对象
                logger.info("picture: " + picture);
                logger.info("picture: " + picture.toString());
                logger.info("picture: " + JSONObject.toJSONString(picture));*/

                //开始读入文件
                /*InputStream in = picture.getBinaryStream();
                OutputStream out = new FileOutputStream("cat.png");
                byte[] buffer = new byte[1024];
                int len = 0;
                while ((len = in.read(buffer)) != -1) {
                    out.write(buffer, 0, len);
                }*/
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void insertBlob() {//插入Blob
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = JDBCTools.getConnection();
            String sql = "INSERT INTO animal(name,age,picture) VALUES(?,?,?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, "TheCat");
            ps.setInt(2, 8);
            InputStream in = new FileInputStream("J:/test1/TomCat.png");//生成被插入文件的节点流
            //设置Blob
            ps.setBlob(3, in);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCTools.release(con, ps);
        }
    }

    public static void main(String[] args) {
        getBlob();
        insertBlob();
        System.exit(0);
    }

    static class JDBCTools {//JDBC工具类  用来建立连接和释放连接
        public static Connection getConnection() throws Exception {//连接数据库
            String driverClass = null;
            String url = null;
            String user = null;
            String password = null;

            Properties properties = new Properties();

            InputStream in = Review.class.getClassLoader().getResourceAsStream("application.properties");
            properties.load(in);

            driverClass = properties.getProperty("spring.datasource.type");
            url = properties.getProperty("spring.datasource.url");
            user = properties.getProperty("spring.datasource.username");
            password = properties.getProperty("spring.datasource.password");
            Class.forName(driverClass);
            return DriverManager.getConnection(url, user, password);
        }

        public static void release(Connection con, Statement state) {//关闭数据库连接
            if (state != null) {
                try {
                    state.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

        }

        public void release(ResultSet rs, Connection con, Statement state) {//关闭数据库连接
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (state != null) {
                try {
                    state.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}

class Review {
    public Connection getConnection() throws Exception {//连接数据库
        String driverClass = null;
        String url = null;
        String user = null;
        String password = null;

        Properties properties = new Properties();

        InputStream in = Review.class.getClassLoader().getResourceAsStream("jdbc.properties");

        properties.load(in);

        driverClass = properties.getProperty("driver");
        url = properties.getProperty("jdbcurl");
        user = properties.getProperty("user");
        password = properties.getProperty("password");
        Class.forName(driverClass);
        return DriverManager.getConnection(url, user, password);
    }

}