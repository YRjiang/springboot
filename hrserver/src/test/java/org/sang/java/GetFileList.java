package org.sang.java;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class GetFileList {

    // 非递归
    public static List<String> scanFiles(String path) {
        List<String> filePaths = new ArrayList<String>();
        File[] listFiles = null;
        LinkedList<File> list = new LinkedList<File>();
        File dir = new File(path);
        File[] file = dir.listFiles();

        for (int i = 0; i < file.length; i++) {
            if (file[i].isDirectory()) {
                // 把第一层的目录，全部放入链表
                list.add(file[i]);
            }
            if (file[i].isFile() && (file[i].getName().endsWith(".java") || file[i].getName().endsWith(".xml"))) {
                filePaths.add(file[i].getAbsolutePath() + "\r\n");
            }
            //filePaths.add(file[i].getAbsolutePath() + "\r\n");
        }
        // 循环遍历链表
        while (!list.isEmpty()) {
            // 把链表的第一个记录删除
            File tmp = list.removeFirst();
            // 如果删除的目录是一个路径的话
            if (tmp.isDirectory()) {
                // 列出这个目录下的文件到数组中
                file = tmp.listFiles();
                if (file == null) {// 空目录
                    continue;
                }
                // 遍历文件数组
                for (int i = 0; i < file.length; ++i) {
                    if (file[i].isDirectory()) {
                        // 如果遍历到的是目录，则将继续被加入链表
                        list.add(file[i]);
                    }
                    if (file[i].isFile()
                            && (file[i].getName().endsWith(".java") || file[i].getName().endsWith(".xml"))) {
                        filePaths.add(file[i].getAbsolutePath() + "\r\n");
                    }
                    //filePaths.add(file[i].getAbsolutePath() + "\r\n");
                }
            }
        }
        try {
            write2File(filePaths, new File(path + "/" + "file2.txt"));
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return filePaths;
    }

    public static void main(String[] args) {
        String path = "E:/0.program/study/hrserver/src";
        List<String> list = new ArrayList<String>();
        list = scanFiles(path);
        //test5();
    }

    /**
     * 将集合中的数据的绝对路径写入到文件中。
     * @param list
     * @param destFile
     * @throws IOException 
     */
    public static void write2File(List<String> list, File destFile) throws IOException {
        FileOutputStream fos = null;
        BufferedOutputStream bufos = null;
        try {
            fos = new FileOutputStream(destFile);
            bufos = new BufferedOutputStream(fos);

            for (String str : list) {
                File file = new File(str);
                String info = file.getAbsolutePath() + File.separator;
                bufos.write(info.getBytes());
                bufos.flush();//每写一个绝对路径就刷新一次。
            }
        } finally {
            if (bufos != null) {
                try {
                    fos.close();
                } catch (IOException e) {
                    throw new RuntimeException("关闭失败");
                }
            }
        }

    }

}
