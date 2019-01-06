/**
 *====================================================
 * 文件名称: ClassUtil.java
 * 修订记录：
 * No    日期				作者(操作:具体内容)
 * 1.    2018年3月8日			chenxy(创建:创建文件)
 *====================================================
 * 类描述：(说明未实现或其它不应生成javadoc的内容)
 */
package org.sang.tcp.common;

import java.io.File;
import java.io.FileFilter;
import java.io.IOException;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.util.Enumeration;
import java.util.HashSet;
import java.util.Set;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

/** 
* @ClassName: ClassUtil 
* @Description: TODO(这里用一句话描述这个类的作用) 
* @author chenxy 
* @date 2018年3月8日 上午11:46:05  
*/
public class ClassUtil {

	/** 获取指定包下面所有的子类 */
	@SuppressWarnings("unchecked")
	public static <T> Set<Class<? extends T>> getAllAssignedClass(Class<T> cls, String packageName) throws IOException, ClassNotFoundException {
		Enumeration<URL> resources = Thread.currentThread().getContextClassLoader().getResources(packageName.replace('.', '/'));
		Set<Class<? extends T>> classes = new HashSet<>();
		while (resources.hasMoreElements()) {
			URL url = resources.nextElement();
			String protocol = url.getProtocol();
			if ("file".equals(protocol)) {
				String filePath = URLDecoder.decode(url.getFile(), "UTF-8");
				File[] clazzFiles = new File(filePath).listFiles(new FileFilter() {
					public boolean accept(File file) {
						return file.getName().endsWith(".class");
					}
				});
				for (File file : clazzFiles) {
					String className = file.getName().substring(0, file.getName().length() - 6);
					// 避免Class.forName()触发static方法
					Class<?> clazz = Thread.currentThread().getContextClassLoader().loadClass(packageName + '.' + className);
					if (cls.isAssignableFrom(clazz) && !clazz.equals(cls)) {
						classes.add((Class<T>) clazz);
					}
				}
			} else if ("jar".equals(protocol)) {
				JarFile jar = ((JarURLConnection) url.openConnection()).getJarFile();
				// 从此jar包 得到一个枚举类
				Enumeration<JarEntry> entries = jar.entries();
				while (entries.hasMoreElements()) { // 同样的进行循环迭代
					// 获取jar里的一个实体 可以是目录 和一些jar包里的其他文件 如META-INF等文件
					JarEntry entry = entries.nextElement();
					if (entry.isDirectory()) { // 目录
						continue;
					}
					String name = entry.getName();
					if (name.charAt(0) == '/') { // 如果是以/开头的
						name = name.substring(1); // 获取后面的字符串
					}
					if (!packageName.equals(name.substring(0, name.lastIndexOf('/')).replace('/', '.'))) { // 包名不匹配
						continue;
					}
					if (!name.endsWith(".class")) { // 如果不是一个.class文件
						continue;
					}
					// 去掉后面的".class" 获取真正的类名
					String className = name.substring(packageName.length() + 1, name.length() - 6);
					Class<?> clazz = Thread.currentThread().getContextClassLoader().loadClass(packageName + '.' + className);
					if (cls.isAssignableFrom(clazz) && !clazz.equals(cls)) {
						classes.add((Class<T>) clazz);
					}
				}
			}
		}
		return classes;
	}

}
