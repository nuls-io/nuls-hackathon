/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80013
 Source Host           : localhost:3306
 Source Schema         : db_videos

 Target Server Type    : MySQL
 Target Server Version : 80013
 File Encoding         : 65001

 Date: 18/08/2019 22:11:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_notice_news
-- ----------------------------
DROP TABLE IF EXISTS `tb_notice_news`;
CREATE TABLE `tb_notice_news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户id',
  `user_types` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '账户类型，0：个人，1：企业',
  `mobile` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `email` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '通知信息',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态值，1:正常，0:禁用',
  `types` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '类别，0:实名认证',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='通知信息表';

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `mobile` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `area_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '手机国际区号',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录密码',
  `salt` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '密码盐',
  `realname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `register_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '注册IP地址',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '头像图片地址',
  `api_token` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '客户端接口生成的token',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '不同的状态值代表不同的操作.1:正常 0:冻结 2:软删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户注册时间',
  `wx_openid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT '' COMMENT '微信登录openid',
  `wx_unionid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '微信登录unionid',
  `nick_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户昵称',
  `user_guuid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户区块ID',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '邮箱(一般是企业注册)',
  `types` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '账户类型,0:普通用户,1:企业用户',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `mobile` (`mobile`) USING BTREE COMMENT '手机号',
  KEY `email` (`email`) USING BTREE COMMENT '邮箱'
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Table structure for tb_user_block
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_block`;
CREATE TABLE `tb_user_block` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `username` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户名或者单位名称',
  `usertype` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '用户类型 0:自然人，1：企业 ，2：政府部门',
  `reg_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '注册时间',
  `reg_platform` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '注册平台',
  `person` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '个人信息\n暂定为JSON格式\n“name”：姓名\n“gender”:性别 0男，1:女\n“ID”:身份ID\n“phoneNum”：移动电话\n“address”：住址\n“nation”：国籍\n',
  `company` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '企业信息\n暂定为JSON格式\n“name”：企业名称\n“creditcode”:社会统一保险号\n“contactpersion”:联系人姓名\n“contactphone”:联系电话',
  `describe` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '信息描述',
  `code` int(11) unsigned NOT NULL DEFAULT '2' COMMENT '结果信息\n0：失败，1：成功，2：等待中',
  `user_guuid` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '用户全局ID',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '2' COMMENT '不同的状态值代表不同的操作\n0：失败，1：已处理，2：待处理',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID',
  KEY `user_guuid` (`user_guuid`) USING BTREE COMMENT '用户全局ID(区块ID)'
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8 COMMENT='用户区块信息表';

-- ----------------------------
-- Table structure for tb_user_log
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_log`;
CREATE TABLE `tb_user_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `user_type` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '账户类型，0:普通用户,1:企业用户',
  `types` tinyint(1) unsigned DEFAULT '0' COMMENT '不同的状态值代表不同的操作,0:登录,1:注册,2:修改密码,3:忘记密码,4:退出,5:版权存证，6:发函下线，7:维权申请，8：API创建，9：API重置，10:API删除，11:实名认证,12:API更新，11,用户开启监测',
  `login_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '操作IP',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '详细描述',
  `result` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '请求结果',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '不同的状态值代表不同的操作，1:正常，0：异常',
  `optime` int(11) unsigned DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID'
) ENGINE=InnoDB AUTO_INCREMENT=255 DEFAULT CHARSET=utf8 COMMENT='前端用户操作日志记录';

-- ----------------------------
-- Table structure for tb_user_login
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_login`;
CREATE TABLE `tb_user_login` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `login_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '登录IP',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID'
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='用户登录日志表';

-- ----------------------------
-- Table structure for tb_user_obligee
-- ----------------------------
DROP TABLE IF EXISTS `tb_user_obligee`;
CREATE TABLE `tb_user_obligee` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `realname` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `id_type` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '证件类型,1：身份证 2:护照 ',
  `id_number` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证件号',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `works_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品Id(后续会进行移除)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID'
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8 COMMENT='权利人表';

-- ----------------------------
-- Table structure for tb_works
-- ----------------------------
DROP TABLE IF EXISTS `tb_works`;
CREATE TABLE `tb_works` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `obligee_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权利人id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '作品名称',
  `author_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '作者名称',
  `types` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '作品类型，1：视频-17，2：音频-23 ,3：图片-43 ,4:文本-35, 0：其他',
  `create_nature` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '创作性质，0:原创，1改编 ,2:翻译 ，3汇编，4注释，5整理，6:其他',
  `copyright_notice` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '版权说明',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '不同的状态值代表不同的操作,0:待审核，1：审核通过(已存证)，2:草稿,3:审核失败',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `works_certificate` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '版权证书',
  `file_data` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件存储位置(暂定存储为JSON格式，具体等写到这个地方在确认)',
  `publish_status` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '发表状态，0:为发表，1:已发表',
  `works_certificatepc` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT 'pc端版权证书',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID',
  KEY `obligee_id` (`obligee_id`) USING BTREE COMMENT '权利人ID'
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8 COMMENT='版权存证表';

-- ----------------------------
-- Table structure for tb_works_copyright
-- ----------------------------
DROP TABLE IF EXISTS `tb_works_copyright`;
CREATE TABLE `tb_works_copyright` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `works_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '作品ID',
  `work_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '作品名称',
  `name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '证书名称',
  `certificate_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '存证ID',
  `catalog` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品类别',
  `fingerprint` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '作品缘指纹信息',
  `work_abstract` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '作品摘要',
  `create_nature` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '创作性质，0:原创，1改编 ,2:翻译 ，3汇编，4注释，5整理，6:其他',
  `work_create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品完成时间',
  `work_publish_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品发表时间',
  `work_apply_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品版权申请时间',
  `applicant_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '申请者ID(链上ID)',
  `applicant_name` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '申请者姓名',
  `issuer_id` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '颁发者ID',
  `issuer_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '颁发者姓名或者单位',
  `right_description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '权利描述\n“right_owner_name”:权利所有人\n“right_owner_id”：权利所有人ID\n“right_expiration”:权利到期时间\n“right_source_type”:权利获得方式\n“right_definition”:权利明细\n\n暂定JSON格式',
  `file_info` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件信息\n“filetype”:文件类型\n“sizes”:文件规格大小\n“hmac”:文件校验码\n“storageLocationURL”:文件存储位置\n\n暂定JSON格式',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '不同的状态值代表不同的操作\n\n0：等待处理，1：处理成功，2:失败\n\n基于区块相应消息',
  `describe` text CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '失败描述',
  `certification_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '版权证书ID',
  `issuer_signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '颁发者签名，对应证书的签名',
  `applicant_signature` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '版权权益签名',
  `block_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '存在区块的ID',
  `txid` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '存在交易ID',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID',
  KEY `works_id` (`works_id`) USING BTREE COMMENT '作品ID',
  KEY `applicant_id` (`applicant_id`) USING BTREE COMMENT '申请者ID(链上)'
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8 COMMENT='版权登记表';

-- ----------------------------
-- Table structure for tb_works_files
-- ----------------------------
DROP TABLE IF EXISTS `tb_works_files`;
CREATE TABLE `tb_works_files` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `works_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品ID',
  `types` tinyint(4) unsigned NOT NULL DEFAULT '1' COMMENT '文件上传类型，1：视频，2：音频，3图片,4：文本,0：未知 ,5:实名认证',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `file_data` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '文件存储位置',
  `status` tinyint(50) unsigned NOT NULL DEFAULT '0' COMMENT '不同的状态值代表不同的操作，0:待确认，1：通过确认，2:草稿箱,3:确认中',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `hash` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '使用sha256对文件内容进行生成hash值',
  `sizes` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '0' COMMENT '文件大小',
  `common_hash` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '多文件的hash再次生成一个hash',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID',
  KEY `works_id` (`works_id`) USING BTREE COMMENT '作品ID'
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8 COMMENT='文件上传位置表(实名认证和作品存证)';

-- ----------------------------
-- Table structure for tb_works_news
-- ----------------------------
DROP TABLE IF EXISTS `tb_works_news`;
CREATE TABLE `tb_works_news` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `works_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '作品ID',
  `title` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '提示信息标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci COMMENT '提示信息内容',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '不同的状态值代表不同的操作，1:正常，2:禁用',
  `types` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '不同的状态值代表不同的操作，1：审核成功，0：审核失败，2：其他',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE COMMENT '用户ID',
  KEY `works_id` (`works_id`) USING BTREE COMMENT '作品ID'
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COMMENT='消息通知表';

SET FOREIGN_KEY_CHECKS = 1;
