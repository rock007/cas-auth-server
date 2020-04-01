/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50562
Source Host           : localhost:3306
Source Database       : auth_center

Target Server Type    : MYSQL
Target Server Version : 50562
File Encoding         : 65001

Date: 2020-03-31 22:48:26
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `sys_attrs`
-- ----------------------------
DROP TABLE IF EXISTS `sys_attrs`;
CREATE TABLE `sys_attrs` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `user_id` varchar(30) DEFAULT NULL,
  `attr_key` varchar(50) DEFAULT NULL,
  `attr_val` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_attrs
-- ----------------------------
INSERT INTO `sys_attrs` VALUES ('1', 'admin', 'group', 'ADMIN_ROLE');
INSERT INTO `sys_attrs` VALUES ('2', 'admin', 'group', 'MANAGEMENT_ROLE');
INSERT INTO `sys_attrs` VALUES ('3', 'admin', 'group', 'DEV_ROLE');
INSERT INTO `sys_attrs` VALUES ('4', 'admin', 'school', 'GuangZhou');
INSERT INTO `sys_attrs` VALUES ('5', 'admin', 'school', 'ZhuHai');
INSERT INTO `sys_attrs` VALUES ('6', 'zhangsan', 'group', 'DEV_ROLE');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` varchar(128) NOT NULL DEFAULT '',
  `user_name` varchar(30) NOT NULL,
  `password` varchar(64) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `expired` int(11) DEFAULT NULL,
  `disable` int(11) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', '123456', 'huang.wenbin@foxmail.com', null, '广州天河', '24', '0', '0');
INSERT INTO `sys_user` VALUES ('2', 'wangwu', '827ccb0eea8a706c4c34a16891f84e7b', 'wangwu@foxmail.com', null, '广州番禺', '27', '1', '0');
INSERT INTO `sys_user` VALUES ('3', 'zhangsan', '25d55ad283aa400af464c76d713c07ad', '756884434@qq.com', null, '广州越秀', '26', '0', '0');
INSERT INTO `sys_user` VALUES ('4', 'zhaosi', '81dc9bdb52d04dc20036dbd8313ed055', 'zhaosi@foxmail.com', null, '广州海珠', '25', '0', '1');

-- ----------------------------
-- Table structure for `sys_user_question`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_question`;
CREATE TABLE `sys_user_question` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` varchar(30) NOT NULL,
  `question` varchar(200) NOT NULL,
  `answer` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of sys_user_question
-- ----------------------------
INSERT INTO `sys_user_question` VALUES ('1', 'admin', '使用过的密码是？', '123');
INSERT INTO `sys_user_question` VALUES ('2', 'admin', '你的年龄是？', '24');
INSERT INTO `sys_user_question` VALUES ('3', 'zhangsan', '我的名字是？', 'zhangsan');
INSERT INTO `sys_user_question` VALUES ('4', 'zhangsan', '我在哪里工作？', 'guangzhou');
