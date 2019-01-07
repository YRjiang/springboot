/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50718
 Source Host           : localhost:3306
 Source Schema         : vhr

 Target Server Type    : MySQL
 Target Server Version : 50718
 File Encoding         : 65001

 Date: 06/01/2019 12:55:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for adjustsalary
-- ----------------------------
DROP TABLE IF EXISTS `adjustsalary`;
CREATE TABLE `adjustsalary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `asDate` date NULL DEFAULT NULL COMMENT '调薪日期',
  `beforeSalary` int(11) NULL DEFAULT NULL COMMENT '调前薪资',
  `afterSalary` int(11) NULL DEFAULT NULL COMMENT '调后薪资',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调薪原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `adjustsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `appDate` date NULL DEFAULT NULL COMMENT '考评日期',
  `appResult` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评结果',
  `appContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '考评内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `appraise_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '部门名称',
  `parentId` int(11) NULL DEFAULT NULL,
  `depPath` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  `isParent` tinyint(1) NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 93 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '股东会', -1, '.1', 1, 1);
INSERT INTO `department` VALUES (4, '董事会', 1, '.1.4', 1, 1);
INSERT INTO `department` VALUES (5, '总办', 4, '.1.4.5', 1, 1);
INSERT INTO `department` VALUES (8, '财务部', 5, '.1.4.5.8', 1, 0);
INSERT INTO `department` VALUES (78, '市场部', 5, '.1.4.5.78', 1, 1);
INSERT INTO `department` VALUES (81, '华北市场部', 78, '.1.4.5.78.81', 1, 1);
INSERT INTO `department` VALUES (82, '华南市场部', 78, '.1.4.5.78.82', 1, 0);
INSERT INTO `department` VALUES (85, '石家庄市场部', 81, '.1.4.5.78.81.85', 1, 0);
INSERT INTO `department` VALUES (86, '西北市场部', 78, '.1.4.5.78.86', 1, 1);
INSERT INTO `department` VALUES (87, '西安市场', 86, '.1.4.5.78.86.87', 1, 1);
INSERT INTO `department` VALUES (89, '莲湖区市场', 87, '.1.4.5.78.86.87.89', 1, 0);
INSERT INTO `department` VALUES (91, '技术部', 5, '.1.4.5.91', 1, 0);
INSERT INTO `department` VALUES (92, '运维部', 5, '.1.4.5.92', 1, 0);

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '性别',
  `birthday` date NULL DEFAULT NULL COMMENT '出生日期',
  `idCard` char(18) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) NULL DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '籍贯',
  `politicId` int(8) NULL DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(11) NULL DEFAULT NULL COMMENT '所属部门',
  `jobLevelId` int(11) NULL DEFAULT NULL COMMENT '职称ID',
  `posId` int(11) NULL DEFAULT NULL COMMENT '职位ID',
  `engageForm` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '聘用形式',
  `tiptopDegree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属专业',
  `school` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '毕业院校',
  `beginDate` date NULL DEFAULT NULL COMMENT '入职日期',
  `workState` enum('在职','离职') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '在职' COMMENT '在职状态',
  `workID` char(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '工号',
  `contractTerm` double NULL DEFAULT NULL COMMENT '合同期限',
  `conversionTime` date NULL DEFAULT NULL COMMENT '转正日期',
  `notWorkDate` date NULL DEFAULT NULL COMMENT '离职日期',
  `beginContract` date NULL DEFAULT NULL COMMENT '合同起始日期',
  `endContract` date NULL DEFAULT NULL COMMENT '合同终止日期',
  `workAge` int(11) NULL DEFAULT NULL COMMENT '工龄',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `departmentId`(`departmentId`) USING BTREE,
  INDEX `jobId`(`jobLevelId`) USING BTREE,
  INDEX `dutyId`(`posId`) USING BTREE,
  INDEX `nationId`(`nationId`) USING BTREE,
  INDEX `politicId`(`politicId`) USING BTREE,
  INDEX `workID_key`(`workID`) USING BTREE,
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`jobLevelId`) REFERENCES `joblevel` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`posId`) REFERENCES `position` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`nationId`) REFERENCES `nation` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`politicId`) REFERENCES `politicsstatus` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1525 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES (1, '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 5, 9, 29, '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', 2, '2018-04-01', NULL, '2018-01-01', '2020-01-01', NULL);
INSERT INTO `employee` VALUES (2, '陈静', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 8, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (3, '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (4, '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (5, '姚森', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (6, '云星', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (7, '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (8, '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (9, '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (10, '张洁', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (11, '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 91, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (12, '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (13, '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (14, '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (15, '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (16, '云星2', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (17, '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (18, '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (19, '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (20, '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (21, '江南一点雨3', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000021', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (22, '陈静3', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000022', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (24, '鹿存亮3', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000024', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (25, '姚森3', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000025', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (26, '云星3', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000026', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (27, '贾旭明3', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000027', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (28, '张黎明3', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000028', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (29, '薛磊3', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000029', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (31, '江南一点雨4', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000031', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (32, '陈静4', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000032', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (33, '赵琳浩4', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000033', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (34, '鹿存亮4', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000034', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (35, '姚森4', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000035', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (36, '云星4', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000036', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (37, '贾旭明4', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000037', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (38, '张黎明2', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000038', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (39, '薛磊4', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000039', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (40, '张洁4', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000040', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (41, '江南一点雨5', '男', '1990-01-01', '610122199001011256', '已婚', 1, '陕西', 13, 'laowang@qq.com', '18565558897', '深圳市南山区', 8, 9, 29, '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000041', 1, '2018-04-01', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (42, '陈静5', '女', '1989-02-01', '421288198902011234', '已婚', 1, '海南', 1, 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', 82, 12, 30, '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000042', 3, '2015-09-10', NULL, '2015-06-09', '2018-06-08', NULL);
INSERT INTO `employee` VALUES (43, '赵琳浩5', '男', '1993-03-04', '610122199303041456', '未婚', 1, '陕西', 3, 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', 91, 12, 33, '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000043', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (44, '鹿存亮5', '男', '1990-01-03', '610122199001031456', '已婚', 1, '陕西', 3, 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', 92, 12, 34, '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000044', 3.5, '2018-04-01', NULL, '2018-01-01', '2021-07-14', NULL);
INSERT INTO `employee` VALUES (45, '姚森5', '男', '1991-02-05', '610122199102058952', '已婚', 1, '河南', 3, 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', 92, 15, 34, '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000045', 7, '2017-04-02', NULL, '2017-01-02', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (46, '云星5', '女', '1993-01-05', '610122199301054789', '已婚', 1, '陕西西安', 1, 'yunxing@qq.com', '15644442252', '陕西西安新城区', 92, 16, 34, '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000046', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (47, '贾旭明5', '男', '1993-11-11', '610122199311111234', '已婚', 1, '广东广州', 4, 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', 78, 15, 33, '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000047', 5.25, '2018-04-01', NULL, '2018-01-01', '2023-04-13', NULL);
INSERT INTO `employee` VALUES (48, '张黎明5', '男', '1991-02-01', '610144199102014569', '已婚', 1, '广东', 6, 'zhangliming@qq.com', '18979994478', '广东珠海', 91, 15, 33, '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000048', 7, '2018-04-01', NULL, '2018-01-01', '2025-01-30', NULL);
INSERT INTO `employee` VALUES (49, '薛磊5', '男', '1992-07-01', '610144199207017895', '已婚', 1, '陕西西安', 13, 'xuelei@qq.com', '15648887741', '西安市雁塔区', 92, 14, 34, '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000049', 6, '2018-04-01', NULL, '2018-01-01', '2024-01-17', NULL);
INSERT INTO `employee` VALUES (50, '张洁5', '女', '1990-10-09', '420177199010093652', '未婚', 1, '海南', 5, 'zhangjie@qq.com', '13695557742', '海口市美兰区', 92, 16, 34, '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000050', 1, '2018-01-31', NULL, '2018-01-01', '2019-01-01', NULL);
INSERT INTO `employee` VALUES (1519, '11', '女', '2018-12-05', '350123199605064596', '离异', 2, '13', 2, '364@qq.com', '18859670865', '123', 85, 12, 31, '劳务合同', '初中', '1312', '123123', '2018-12-18', '在职', '00000051', 0, '2018-12-25', NULL, '2018-12-25', '2018-12-18', NULL);
INSERT INTO `employee` VALUES (1520, '11', '女', '2018-12-05', '350123199605064596', '离异', 2, '13', 2, '364@qq.com', '18859670865', '123', 85, 12, 31, '劳务合同', '初中', '1312', '123123', '2018-12-18', '在职', '00000051', 0, '2018-12-25', NULL, '2018-12-25', '2018-12-18', NULL);
INSERT INTO `employee` VALUES (1521, '11', '女', '2018-12-05', '350123199605064596', '离异', 2, '13', 2, '364@qq.com', '18859670865', '123', 85, 12, 31, '劳务合同', '初中', '1312', '123123', '2018-12-18', '在职', '00000051', 0, '2018-12-25', NULL, '2018-12-25', '2018-12-18', NULL);
INSERT INTO `employee` VALUES (1522, '江北', '男', '2018-12-05', '350123199602056589', '已婚', 3, '好', 1, '904293471@qq.com', '18859670787', '阿斯蒂芬 ', 78, 10, 29, '劳动合同', '本科', '阿斯顿发送到', '发的', '2018-12-13', '在职', '00000052', 0, '2018-12-19', NULL, '2018-12-25', '2018-12-31', NULL);
INSERT INTO `employee` VALUES (1523, '江夏', '女', '2018-12-04', '350123196902054569', '已婚', 3, '发', 3, 'yerong@yusys.com.cn', '18859670787', 'sdaf ', 86, 10, 31, '劳动合同', '高中', 'sdfasdfasd', 'sdf ', '2018-12-03', '在职', '00000053', 0, '2018-12-06', NULL, '2018-12-18', '2018-12-26', NULL);
INSERT INTO `employee` VALUES (1524, '111', '女', '2018-12-04', '352011199305069596', '未婚', 3, '11', 3, 'yerong@yusys.com.cn', '18859670787', '1231', 82, 12, 30, '劳动合同', '高中', '123123', '1231', '2018-12-04', '在职', '00000054', 0, '2018-12-07', NULL, '2018-12-17', '2018-12-28', NULL);

-- ----------------------------
-- Table structure for employeeec
-- ----------------------------
DROP TABLE IF EXISTS `employeeec`;
CREATE TABLE `employeeec`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL COMMENT '员工编号',
  `ecDate` date NULL DEFAULT NULL COMMENT '奖罚日期',
  `ecReason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '奖罚原因',
  `ecPoint` int(11) NULL DEFAULT NULL COMMENT '奖罚分',
  `ecType` int(11) NULL DEFAULT NULL COMMENT '奖罚类别，0：奖，1：罚',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employeeec_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employeeremove
-- ----------------------------
DROP TABLE IF EXISTS `employeeremove`;
CREATE TABLE `employeeremove`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `afterDepId` int(11) NULL DEFAULT NULL COMMENT '调动后部门',
  `afterJobId` int(11) NULL DEFAULT NULL COMMENT '调动后职位',
  `removeDate` date NULL DEFAULT NULL COMMENT '调动日期',
  `reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '调动原因',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employeeremove_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employeetrain
-- ----------------------------
DROP TABLE IF EXISTS `employeetrain`;
CREATE TABLE `employeetrain`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL COMMENT '员工编号',
  `trainDate` date NULL DEFAULT NULL COMMENT '培训日期',
  `trainContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '培训内容',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `pid`(`eid`) USING BTREE,
  CONSTRAINT `employeetrain_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for empsalary
-- ----------------------------
DROP TABLE IF EXISTS `empsalary`;
CREATE TABLE `empsalary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) NULL DEFAULT NULL,
  `sid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `eid`(`eid`) USING BTREE,
  INDEX `empsalary_ibfk_2`(`sid`) USING BTREE,
  CONSTRAINT `empsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `empsalary_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `salary` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empsalary
-- ----------------------------
INSERT INTO `empsalary` VALUES (6, 4, 10);
INSERT INTO `empsalary` VALUES (7, 3, 9);
INSERT INTO `empsalary` VALUES (8, 1, 10);
INSERT INTO `empsalary` VALUES (10, 5, 9);
INSERT INTO `empsalary` VALUES (11, 6, 13);
INSERT INTO `empsalary` VALUES (12, 7, 13);
INSERT INTO `empsalary` VALUES (13, 2, 13);
INSERT INTO `empsalary` VALUES (14, 8, 10);
INSERT INTO `empsalary` VALUES (15, 9, 10);
INSERT INTO `empsalary` VALUES (16, 10, 13);
INSERT INTO `empsalary` VALUES (17, 14, 13);
INSERT INTO `empsalary` VALUES (18, 28, 15);

-- ----------------------------
-- Table structure for hr
-- ----------------------------
DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'hrID',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` char(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '住宅电话',
  `address` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '联系地址',
  `enabled` tinyint(1) NULL DEFAULT 1,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `userface` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 706 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hr
-- ----------------------------
INSERT INTO `hr` VALUES (3, '系统管理员', '18568887789', '029-82881234', '深圳南山', 1, 'admin', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', NULL);
INSERT INTO `hr` VALUES (5, '李白', '18568123489', '029-82123434', '海口美兰', 1, 'libai', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', NULL);
INSERT INTO `hr` VALUES (10, '韩愈', '18568123666', '029-82111555', '广州番禺', 1, 'hanyu', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1406745149,1563524794&fm=27&gp=0.jpg', NULL);
INSERT INTO `hr` VALUES (11, '柳宗元', '18568123377', '029-82111333', '广州天河', 1, 'liuzongyuan', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515233756&di=0856d923a0a37a87fd26604a2c871370&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.qqzhi.com%2Fuploadpic%2F2014-09-27%2F041716704.jpg', NULL);
INSERT INTO `hr` VALUES (12, '曾巩', '18568128888', '029-82111222', '广州越秀', 1, 'zenggong', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', NULL);
INSERT INTO `hr` VALUES (705, 'web 测试', NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for hr_role
-- ----------------------------
DROP TABLE IF EXISTS `hr_role`;
CREATE TABLE `hr_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hrid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `hr_role_ibfk_1`(`hrid`) USING BTREE,
  CONSTRAINT `hr_role_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `hr_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 51 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of hr_role
-- ----------------------------
INSERT INTO `hr_role` VALUES (50, 3, 1);

-- ----------------------------
-- Table structure for job_entity
-- ----------------------------
DROP TABLE IF EXISTS `job_entity`;
CREATE TABLE `job_entity`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `group` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cron` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `parameter` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `vm_param` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `jar_path` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `icon` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_entity
-- ----------------------------
INSERT INTO `job_entity` VALUES (1, 'first', 'helloworld', '0/30 * * * * ? ', '1', '第一个/30秒', '', NULL, NULL, 'OPEN');
INSERT INTO `job_entity` VALUES (2, 'second', 'helloworld', '0/30 * * * * ? ', '2', '第二个/60秒', NULL, NULL, NULL, 'OPEN');
INSERT INTO `job_entity` VALUES (4, 'third', 'helloworld', '40 * * * * ? ', '3', '第三个/2分', NULL, NULL, NULL, 'OPEN');
INSERT INTO `job_entity` VALUES (5, 'four', 'helloworld', '0 0/1 * * * ? *', '4', '第四个', NULL, NULL, NULL, 'CLOSE');
INSERT INTO `job_entity` VALUES (6, 'OLAY Job', 'Nomal', '0 0/2 * * * ?', '5', '第五个', NULL, 'C:\\EalenXie\\Download\\JDE-Order-1.0-SNAPSHOT.jar', NULL, 'CLOSE');
INSERT INTO `job_entity` VALUES (7, 'sms', 'message', '0/5 * * * * ? ', '6', '短信', NULL, NULL, 'fa fa-windows', 'OPEN');
INSERT INTO `job_entity` VALUES (8, 'email', 'message', '0/10 * * * * ?', '8', '邮件', NULL, NULL, NULL, 'OPEN');

-- ----------------------------
-- Table structure for joblevel
-- ----------------------------
DROP TABLE IF EXISTS `joblevel`;
CREATE TABLE `joblevel`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职称名称',
  `titleLevel` enum('正高级','副高级','中级','初级','员级') CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createDate` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of joblevel
-- ----------------------------
INSERT INTO `joblevel` VALUES (9, '教授', '正高级', '2018-01-11 21:19:14', 1);
INSERT INTO `joblevel` VALUES (10, '副教授', '副高级', '2018-01-11 21:19:20', 1);
INSERT INTO `joblevel` VALUES (12, '助教', '初级', '2018-01-11 21:35:39', 1);
INSERT INTO `joblevel` VALUES (13, '讲师', '中级', '2018-01-11 22:42:12', 1);
INSERT INTO `joblevel` VALUES (14, '初级工程师', '初级', '2018-01-14 16:18:50', 1);
INSERT INTO `joblevel` VALUES (15, '中级工程师', '中级', '2018-01-14 16:19:00', 1);
INSERT INTO `joblevel` VALUES (16, '高级工程师', '副高级', '2018-01-14 16:19:14', 1);
INSERT INTO `joblevel` VALUES (17, '骨灰级工程师', '正高级', '2018-01-14 16:19:24', 1);

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `path` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `component` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `iconCls` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `keepAlive` tinyint(1) NULL DEFAULT NULL,
  `requireAuth` tinyint(1) NULL DEFAULT NULL,
  `parentId` int(11) NULL DEFAULT NULL,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `parentId`(`parentId`) USING BTREE,
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 702 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '/', NULL, NULL, '所有', NULL, NULL, NULL, NULL, 1);
INSERT INTO `menu` VALUES (2, '/', '/home', 'Home', '员工资料', 'fa fa-user-circle-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (3, '/', '/home', 'Home', '人事管理', 'fa fa-address-card-o', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (4, '/', '/home', 'Home', '薪资管理', 'fa fa-money', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (5, '/', '/home', 'Home', '统计管理', 'fa fa-bar-chart', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (6, '/', '/home', 'Home', '系统管理', 'fa fa-windows', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (7, '/', '/home', 'Home', '功能管理', 'fa fa-windows', NULL, 1, 1, 1);
INSERT INTO `menu` VALUES (207, '/employee/basic/**', '/emp/basic', 'EmpBasic', '基本资料', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (208, '/employee/advanced/**', '/emp/adv', 'EmpAdv', '高级资料', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (209, '/employee/expanding/**', '/emp/exp', 'EmpExpand', '额外资料', NULL, NULL, 1, 2, 1);
INSERT INTO `menu` VALUES (309, '/personnel/emp/**', '/per/emp', 'PerEmp', '员工资料', NULL, NULL, 1, 3, 0);
INSERT INTO `menu` VALUES (310, '/personnel/ec/**', '/per/ec', 'PerEc', '员工奖惩', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (311, '/personnel/train/**', '/per/train', 'PerTrain', '员工培训', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (312, '/personnel/salary/**', '/per/salary', 'PerSalary', '员工调薪', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (313, '/personnel/remove/**', '/per/mv', 'PerMv', '员工调动', NULL, NULL, 1, 3, 1);
INSERT INTO `menu` VALUES (404, '/salary/sob/**', '/sal/sob', 'SalSob', '工资账套管理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (405, '/salary/sobcfg/**', '/sal/sobcfg', 'SalSobCfg', '员工账套设置', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (406, '/salary/table/**', '/sal/table', 'SalTable', '工资表管理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (407, '/salary/month/**', '/sal/month', 'SalMonth', '月末处理', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (408, '/salary/search/**', '/sal/search', 'SalSearch', '工资表查询', NULL, NULL, 1, 4, 1);
INSERT INTO `menu` VALUES (509, '/statistics/all/**', '/sta/all', 'StaAll', '综合信息统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (510, '/statistics/score/**', '/sta/score', 'StaScore', '员工积分统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (511, '/statistics/personnel/**', '/sta/pers', 'StaPers', '人事信息统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (512, '/statistics/recored/**', '/sta/record', 'StaRecord', '人事记录统计', NULL, NULL, 1, 5, 1);
INSERT INTO `menu` VALUES (603, '/system/basic/**', '/sys/basic', 'SysBasic', '基础信息设置', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (604, '/system/cfg/**', '/sys/cfg', 'SysCfg', '系统管理', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (605, '/system/log/**', '/sys/log', 'SysLog', '操作日志管理', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (606, '/system/hr/**', '/sys/hr', 'SysHr', '操作员管理', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (607, '/system/data/**', '/sys/data', 'SysData', '备份恢复数据库', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (608, '/system/init/**', '/sys/init', 'SysInit', '初始化数据库', NULL, NULL, 1, 6, 1);
INSERT INTO `menu` VALUES (701, '/function/resource/**', '/function/resource', 'Resource', '资源管理', NULL, NULL, 1, 7, 1);

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NULL DEFAULT NULL,
  `rid` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `mid`(`mid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `menu` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 305 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES (280, 207, 1);
INSERT INTO `menu_role` VALUES (281, 208, 1);
INSERT INTO `menu_role` VALUES (282, 309, 1);
INSERT INTO `menu_role` VALUES (283, 310, 1);
INSERT INTO `menu_role` VALUES (284, 311, 1);
INSERT INTO `menu_role` VALUES (285, 312, 1);
INSERT INTO `menu_role` VALUES (286, 313, 1);
INSERT INTO `menu_role` VALUES (287, 404, 1);
INSERT INTO `menu_role` VALUES (288, 405, 1);
INSERT INTO `menu_role` VALUES (289, 406, 1);
INSERT INTO `menu_role` VALUES (290, 407, 1);
INSERT INTO `menu_role` VALUES (291, 408, 1);
INSERT INTO `menu_role` VALUES (292, 509, 1);
INSERT INTO `menu_role` VALUES (293, 510, 1);
INSERT INTO `menu_role` VALUES (294, 511, 1);
INSERT INTO `menu_role` VALUES (295, 512, 1);
INSERT INTO `menu_role` VALUES (296, 603, 1);
INSERT INTO `menu_role` VALUES (297, 604, 1);
INSERT INTO `menu_role` VALUES (298, 605, 1);
INSERT INTO `menu_role` VALUES (299, 606, 1);
INSERT INTO `menu_role` VALUES (300, 607, 1);
INSERT INTO `menu_role` VALUES (301, 608, 1);
INSERT INTO `menu_role` VALUES (302, 701, 1);
INSERT INTO `menu_role` VALUES (304, 209, 1);

-- ----------------------------
-- Table structure for msgcontent
-- ----------------------------
DROP TABLE IF EXISTS `msgcontent`;
CREATE TABLE `msgcontent`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createDate` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of msgcontent
-- ----------------------------
INSERT INTO `msgcontent` VALUES (14, '2222222222', '11111111111111111', '2018-02-02 20:46:19');
INSERT INTO `msgcontent` VALUES (15, '22222222', '3333333333333333333333', '2018-02-02 21:45:57');
INSERT INTO `msgcontent` VALUES (16, '通知标题1', '通知内容1', '2018-02-03 11:41:39');
INSERT INTO `msgcontent` VALUES (17, '通知标题2', '通知内容2', '2018-02-03 11:52:37');
INSERT INTO `msgcontent` VALUES (18, '通知标题3', '通知内容3', '2018-02-03 12:19:41');

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of nation
-- ----------------------------
INSERT INTO `nation` VALUES (1, '汉族');
INSERT INTO `nation` VALUES (2, '蒙古族');
INSERT INTO `nation` VALUES (3, '回族');
INSERT INTO `nation` VALUES (4, '藏族');
INSERT INTO `nation` VALUES (5, '维吾尔族');
INSERT INTO `nation` VALUES (6, '苗族');
INSERT INTO `nation` VALUES (7, '彝族');
INSERT INTO `nation` VALUES (8, '壮族');
INSERT INTO `nation` VALUES (9, '布依族');
INSERT INTO `nation` VALUES (10, '朝鲜族');
INSERT INTO `nation` VALUES (11, '满族');
INSERT INTO `nation` VALUES (12, '侗族');
INSERT INTO `nation` VALUES (13, '瑶族');
INSERT INTO `nation` VALUES (14, '白族');
INSERT INTO `nation` VALUES (15, '土家族');
INSERT INTO `nation` VALUES (16, '哈尼族');
INSERT INTO `nation` VALUES (17, '哈萨克族');
INSERT INTO `nation` VALUES (18, '傣族');
INSERT INTO `nation` VALUES (19, '黎族');
INSERT INTO `nation` VALUES (20, '傈僳族');
INSERT INTO `nation` VALUES (21, '佤族');
INSERT INTO `nation` VALUES (22, '畲族');
INSERT INTO `nation` VALUES (23, '高山族');
INSERT INTO `nation` VALUES (24, '拉祜族');
INSERT INTO `nation` VALUES (25, '水族');
INSERT INTO `nation` VALUES (26, '东乡族');
INSERT INTO `nation` VALUES (27, '纳西族');
INSERT INTO `nation` VALUES (28, '景颇族');
INSERT INTO `nation` VALUES (29, '柯尔克孜族');
INSERT INTO `nation` VALUES (30, '土族');
INSERT INTO `nation` VALUES (31, '达斡尔族');
INSERT INTO `nation` VALUES (32, '仫佬族');
INSERT INTO `nation` VALUES (33, '羌族');
INSERT INTO `nation` VALUES (34, '布朗族');
INSERT INTO `nation` VALUES (35, '撒拉族');
INSERT INTO `nation` VALUES (36, '毛难族');
INSERT INTO `nation` VALUES (37, '仡佬族');
INSERT INTO `nation` VALUES (38, '锡伯族');
INSERT INTO `nation` VALUES (39, '阿昌族');
INSERT INTO `nation` VALUES (40, '普米族');
INSERT INTO `nation` VALUES (41, '塔吉克族');
INSERT INTO `nation` VALUES (42, '怒族');
INSERT INTO `nation` VALUES (43, '乌孜别克族');
INSERT INTO `nation` VALUES (44, '俄罗斯族');
INSERT INTO `nation` VALUES (45, '鄂温克族');
INSERT INTO `nation` VALUES (46, '崩龙族');
INSERT INTO `nation` VALUES (47, '保安族');
INSERT INTO `nation` VALUES (48, '裕固族');
INSERT INTO `nation` VALUES (49, '京族');
INSERT INTO `nation` VALUES (50, '塔塔尔族');
INSERT INTO `nation` VALUES (51, '独龙族');
INSERT INTO `nation` VALUES (52, '鄂伦春族');
INSERT INTO `nation` VALUES (53, '赫哲族');
INSERT INTO `nation` VALUES (54, '门巴族');
INSERT INTO `nation` VALUES (55, '珞巴族');
INSERT INTO `nation` VALUES (56, '基诺族');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addDate` date NULL DEFAULT NULL COMMENT '添加日期',
  `operate` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作内容',
  `hrid` int(11) NULL DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hrid`(`hrid`) USING BTREE,
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for politicsstatus
-- ----------------------------
DROP TABLE IF EXISTS `politicsstatus`;
CREATE TABLE `politicsstatus`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of politicsstatus
-- ----------------------------
INSERT INTO `politicsstatus` VALUES (1, '中共党员');
INSERT INTO `politicsstatus` VALUES (2, '中共预备党员');
INSERT INTO `politicsstatus` VALUES (3, '共青团员');
INSERT INTO `politicsstatus` VALUES (4, '民革党员');
INSERT INTO `politicsstatus` VALUES (5, '民盟盟员');
INSERT INTO `politicsstatus` VALUES (6, '民建会员');
INSERT INTO `politicsstatus` VALUES (7, '民进会员');
INSERT INTO `politicsstatus` VALUES (8, '农工党党员');
INSERT INTO `politicsstatus` VALUES (9, '致公党党员');
INSERT INTO `politicsstatus` VALUES (10, '九三学社社员');
INSERT INTO `politicsstatus` VALUES (11, '台盟盟员');
INSERT INTO `politicsstatus` VALUES (12, '无党派民主人士');
INSERT INTO `politicsstatus` VALUES (13, '普通公民');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '职位',
  `createDate` timestamp(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 36 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES (29, '技术总监', '2018-01-11 21:13:42', 1);
INSERT INTO `position` VALUES (30, '运营总监', '2018-01-11 21:13:48', 1);
INSERT INTO `position` VALUES (31, '市场总监', '2018-01-11 21:13:56', 1);
INSERT INTO `position` VALUES (32, '总经理', '2018-01-11 21:35:07', 1);
INSERT INTO `position` VALUES (33, '研发工程师', '2018-01-14 16:07:11', 1);
INSERT INTO `position` VALUES (34, '运维工程师', '2018-01-14 16:11:41', 1);
INSERT INTO `position` VALUES (35, '技术支持', '2018-11-28 23:09:52', 1);

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `BLOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `SCHED_NAME`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `CRON_EXPRESSION` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('schedulerFactoryBean', 'email', 'message', '0/10 * * * * ?', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('schedulerFactoryBean', 'first', 'helloworld', '0/30 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('schedulerFactoryBean', 'second', 'helloworld', '0/30 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('schedulerFactoryBean', 'sms', 'message', '0/5 * * * * ? ', 'Asia/Shanghai');
INSERT INTO `qrtz_cron_triggers` VALUES ('schedulerFactoryBean', 'third', 'helloworld', '40 * * * * ? ', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ENTRY_ID` varchar(95) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `ENTRY_ID`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`SCHED_NAME`, `INSTANCE_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
INSERT INTO `qrtz_fired_triggers` VALUES ('schedulerFactoryBean', 'yr-PC15467442158831546744217337', 'sms', 'message', 'yr-PC1546744215883', 1546746795215, 1546746800000, 5, 'ACQUIRED', NULL, NULL, '0', '0');

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_DURABLE` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_J_REQ_RECOVERY`(`SCHED_NAME`, `REQUESTS_RECOVERY`) USING BTREE,
  INDEX `IDX_QRTZ_J_GRP`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('schedulerFactoryBean', 'email', 'message', '邮件', 'org.sang.job.DynamicJob', '1', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000974000E63726F6E45787072657373696F6E74000E302F3130202A202A202A202A203F740007766D506172616D7074000E4A6F624465736372697074696F6E740006E982AEE4BBB67400076A61725061746870740009706172616D65746572740001387400046E616D65740005656D61696C74000469636F6E7074000567726F75707400076D6573736167657400067374617475737400044F50454E7800);
INSERT INTO `qrtz_job_details` VALUES ('schedulerFactoryBean', 'first', 'helloworld', '第一个/30秒', 'org.sang.job.DynamicJob', '1', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000974000E63726F6E45787072657373696F6E74000F302F3330202A202A202A202A203F20740007766D506172616D74000074000E4A6F624465736372697074696F6E74000FE7ACACE4B880E4B8AA2F3330E7A7927400076A61725061746870740009706172616D65746572740001317400046E616D65740005666972737474000469636F6E7074000567726F757074000A68656C6C6F776F726C647400067374617475737400044F50454E7800);
INSERT INTO `qrtz_job_details` VALUES ('schedulerFactoryBean', 'second', 'helloworld', '第二个/60秒', 'org.sang.job.DynamicJob', '1', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000974000E63726F6E45787072657373696F6E74000F302F3330202A202A202A202A203F20740007766D506172616D7074000E4A6F624465736372697074696F6E74000FE7ACACE4BA8CE4B8AA2F3630E7A7927400076A61725061746870740009706172616D65746572740001327400046E616D657400067365636F6E6474000469636F6E7074000567726F757074000A68656C6C6F776F726C647400067374617475737400044F50454E7800);
INSERT INTO `qrtz_job_details` VALUES ('schedulerFactoryBean', 'sms', 'message', '短信', 'org.sang.job.DynamicJob', '1', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000974000E63726F6E45787072657373696F6E74000E302F35202A202A202A202A203F20740007766D506172616D7074000E4A6F624465736372697074696F6E740006E79FADE4BFA17400076A61725061746870740009706172616D65746572740001367400046E616D65740003736D7374000469636F6E74000D66612066612D77696E646F777374000567726F75707400076D6573736167657400067374617475737400044F50454E7800);
INSERT INTO `qrtz_job_details` VALUES ('schedulerFactoryBean', 'third', 'helloworld', '第三个/2分', 'org.sang.job.DynamicJob', '1', '1', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C7708000000100000000974000E63726F6E45787072657373696F6E74000D3430202A202A202A202A203F20740007766D506172616D7074000E4A6F624465736372697074696F6E74000EE7ACACE4B889E4B8AA2F32E588867400076A61725061746870740009706172616D65746572740001337400046E616D65740005746869726474000469636F6E7074000567726F757074000A68656C6C6F776F726C647400067374617475737400044F50454E7800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LOCK_NAME` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `LOCK_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'STATE_ACCESS');
INSERT INTO `qrtz_locks` VALUES ('schedulerFactoryBean', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `INSTANCE_NAME`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------
INSERT INTO `qrtz_scheduler_state` VALUES ('schedulerFactoryBean', 'yr-PC1546744215883', 1546746796849, 7500);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `STR_PROP_1` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_2` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `STR_PROP_3` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `INT_PROP_1` int(11) NULL DEFAULT NULL,
  `INT_PROP_2` int(11) NULL DEFAULT NULL,
  `LONG_PROP_1` bigint(20) NULL DEFAULT NULL,
  `LONG_PROP_2` bigint(20) NULL DEFAULT NULL,
  `DEC_PROP_1` decimal(13, 4) NULL DEFAULT NULL,
  `DEC_PROP_2` decimal(13, 4) NULL DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `SCHED_NAME` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `JOB_GROUP` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `DESCRIPTION` varchar(250) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) NULL DEFAULT NULL,
  `PRIORITY` int(11) NULL DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) NULL DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) NULL DEFAULT NULL,
  `JOB_DATA` blob NULL,
  PRIMARY KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`SCHED_NAME`, `JOB_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`SCHED_NAME`, `CALENDAR_NAME`) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`SCHED_NAME`, `TRIGGER_GROUP`) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`SCHED_NAME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`SCHED_NAME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`SCHED_NAME`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`SCHED_NAME`, `TRIGGER_STATE`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_STATE`) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`SCHED_NAME`, `MISFIRE_INSTR`, `NEXT_FIRE_TIME`, `TRIGGER_GROUP`, `TRIGGER_STATE`) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('schedulerFactoryBean', 'email', 'message', 'email', 'message', NULL, 1546746800000, 1546746790000, 5, 'WAITING', 'CRON', 1546744223000, 0, NULL, 0, '');
INSERT INTO `qrtz_triggers` VALUES ('schedulerFactoryBean', 'first', 'helloworld', 'first', 'helloworld', NULL, 1546746810000, 1546746780000, 5, 'WAITING', 'CRON', 1546744222000, 0, NULL, 0, '');
INSERT INTO `qrtz_triggers` VALUES ('schedulerFactoryBean', 'second', 'helloworld', 'second', 'helloworld', NULL, 1546746810000, 1546746780000, 5, 'WAITING', 'CRON', 1546744223000, 0, NULL, 0, '');
INSERT INTO `qrtz_triggers` VALUES ('schedulerFactoryBean', 'sms', 'message', 'sms', 'message', NULL, 1546746800000, 1546746795000, 5, 'ACQUIRED', 'CRON', 1546744223000, 0, NULL, 0, '');
INSERT INTO `qrtz_triggers` VALUES ('schedulerFactoryBean', 'third', 'helloworld', 'third', 'helloworld', NULL, 1546746820000, 1546746760000, 5, 'WAITING', 'CRON', 1546744223000, 0, NULL, 0, '');

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nameZh` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES (1, 'ROLE_admin', '系统管理员');
INSERT INTO `role` VALUES (2, 'ROLE_manager', '部门经理');
INSERT INTO `role` VALUES (3, 'ROLE_personnel', '人事专员');
INSERT INTO `role` VALUES (4, 'ROLE_recruiter', '招聘主管');
INSERT INTO `role` VALUES (5, 'ROLE_train', '培训主管');
INSERT INTO `role` VALUES (6, 'ROLE_performance', '薪酬绩效主管');
INSERT INTO `role` VALUES (13, 'ROLE_test2', '测试角色2');
INSERT INTO `role` VALUES (14, 'ROLE_test1', '测试角色1');

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basicSalary` int(11) NULL DEFAULT NULL COMMENT '基本工资',
  `bonus` int(11) NULL DEFAULT NULL COMMENT '奖金',
  `lunchSalary` int(11) NULL DEFAULT NULL COMMENT '午餐补助',
  `trafficSalary` int(11) NULL DEFAULT NULL COMMENT '交通补助',
  `allSalary` int(11) NULL DEFAULT NULL COMMENT '应发工资',
  `pensionBase` int(11) NULL DEFAULT NULL COMMENT '养老金基数',
  `pensionPer` float NULL DEFAULT NULL COMMENT '养老金比率',
  `createDate` timestamp(0) NULL DEFAULT NULL COMMENT '启用时间',
  `medicalBase` int(11) NULL DEFAULT NULL COMMENT '医疗基数',
  `medicalPer` float NULL DEFAULT NULL COMMENT '医疗保险比率',
  `accumulationFundBase` int(11) NULL DEFAULT NULL COMMENT '公积金基数',
  `accumulationFundPer` float NULL DEFAULT NULL COMMENT '公积金比率',
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES (9, 9000, 4000, 800, 500, NULL, 2000, 0.07, '2018-01-24 00:00:00', 2000, 0.07, 2000, 0.07, '市场部工资账套');
INSERT INTO `salary` VALUES (10, 2000, 2000, 400, 1000, NULL, 2000, 0.07, '2018-01-01 00:00:00', 2000, 0.07, 2000, 0.07, '人事部工资账套');
INSERT INTO `salary` VALUES (13, 10000, 3000, 500, 500, NULL, 4000, 0.07, '2018-01-25 00:00:00', 4000, 0.07, 4000, 0.07, '运维部工资账套');
INSERT INTO `salary` VALUES (14, 4, 23423, 42342, 3, NULL, 4, 4, '2018-11-21 00:00:00', 3, 3, 4, 3, '方法');
INSERT INTO `salary` VALUES (15, 4, 23423, 42342, 3, NULL, 4, 4, '2018-11-21 00:00:00', 3, 3, 4, 3, '个');

-- ----------------------------
-- Table structure for sysmsg
-- ----------------------------
DROP TABLE IF EXISTS `sysmsg`;
CREATE TABLE `sysmsg`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) NULL DEFAULT NULL COMMENT '消息id',
  `type` int(11) NULL DEFAULT 0 COMMENT '0表示群发消息',
  `hrid` int(11) NULL DEFAULT NULL COMMENT '这条消息是给谁的',
  `state` int(11) NULL DEFAULT 0 COMMENT '0 未读 1 已读',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `hrid`(`hrid`) USING BTREE,
  INDEX `sysmsg_ibfk_1`(`mid`) USING BTREE,
  CONSTRAINT `sysmsg_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `msgcontent` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sysmsg_ibfk_2` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 82 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sysmsg
-- ----------------------------
INSERT INTO `sysmsg` VALUES (57, 14, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (58, 14, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (59, 14, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (60, 14, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (61, 14, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (62, 15, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (63, 15, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (64, 15, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (65, 15, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (66, 15, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (67, 16, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (68, 16, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (69, 16, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (70, 16, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (71, 16, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (72, 17, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (73, 17, 0, 5, 1);
INSERT INTO `sysmsg` VALUES (74, 17, 0, 10, 1);
INSERT INTO `sysmsg` VALUES (75, 17, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (76, 17, 0, 12, 0);
INSERT INTO `sysmsg` VALUES (77, 18, 0, 3, 1);
INSERT INTO `sysmsg` VALUES (78, 18, 0, 5, 0);
INSERT INTO `sysmsg` VALUES (79, 18, 0, 10, 0);
INSERT INTO `sysmsg` VALUES (80, 18, 0, 11, 0);
INSERT INTO `sysmsg` VALUES (81, 18, 0, 12, 0);

-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
  declare did int;
  declare pDepPath varchar(64);
  insert into department set name=depName,parentId=parentId,enabled=enabled;
  select row_count() into result;
  select last_insert_id() into did;
  set result2=did;
  select depPath into pDepPath from department where id=parentId;
  update department set depPath=concat(pDepPath,'.',did) where id=did;
  update department set isParent=true where id=parentId;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDep`(in did int,out result int)
begin
  declare ecount int;
  declare pid int;
  declare pcount int;
  select count(*) into ecount from employee where departmentId=did;
  if ecount>0 then set result=-1;
  else 
  select parentId into pid from department where id=did;
  delete from department where id=did and isParent=false;
  select row_count() into result;
  select count(*) into pcount from department where parentId=pid;
  if pcount=0 then update department set isParent=false where id=pid;
  end if;
  end if;
end
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
