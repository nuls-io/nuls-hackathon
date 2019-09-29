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

 Date: 18/08/2019 22:12:08
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
-- Records of tb_user
-- ----------------------------
BEGIN;
INSERT INTO `tb_user` VALUES (1, 'ye1209mx', '1783990623811', '', '9d46a71e0f29aa6a0d7ab766b06735fd', '738231', '', '::1', '', 'b44746e68f41791e0293a48be38cba3ccb218bf4', 1, 1557803793, '', '', '', '', '', 0);
INSERT INTO `tb_user` VALUES (2, 'ye1209mx', '17839906233', '86', '6e487ccae90b380183c06650796578d6', '698736', '', '::1', '', '806609ba9774c20ba64513203130e370505cc31e', 1, 1557804546, '', '', '', '', '', 0);
INSERT INTO `tb_user` VALUES (5, '', '17839906235', '86', 'd40d93054648269e2f1c1235a934e887', '114753', '', '::1', '', 'a27136a6a412a0ff2de20fc465269de91a7e1190', 1, 1557804546, '', '', 'asdf12223', 'b76535a0ae7a86813d1', '', 0);
INSERT INTO `tb_user` VALUES (6, '', '17839906234', '86', '78f6aa10172ac07fc79eb6cc69e30731', '481775', '', '::1', '', '', 1, 1558494876, '', '', '', '', '', 0);
INSERT INTO `tb_user` VALUES (7, '', '17839906232', '86', 'b97067f0538145bd2e9da6a388a8efdf', '057169', '', '::1', '', '', 1, 1558495078, '', '', '', '', '', 0);
INSERT INTO `tb_user` VALUES (8, '', '17839906254', '86', 'a2ac9cf188e4d40cd60e35c8be4682be', '868747', '', '::1', '', '', 1, 1558495452, '', '', '', '', '', 0);
INSERT INTO `tb_user` VALUES (10, '', '15756261450', '86', '', '', '', '', '', '', 0, 0, '', '', '', '0cac48d4be5e58b51fc', '', 0);
INSERT INTO `tb_user` VALUES (11, '', '17839906256', '86', '53e40e25a76647832f571f466328988d', '938185', '', '::1', '', '29f4ed23cd58e3101f35a307b70b69809b5d9feb', 1, 1559036019, '', '', '178****6256', '9fecc7f091e0ad6d809', '', 0);
INSERT INTO `tb_user` VALUES (12, '', '13671927744', '86', 'ea53254595ef279fa81be0dfafcedf5b', '443229', '', '::1', '', '', 1, 1559785996, '', '', '136****7744', '610239b380d9101b9b6', '', 0);
INSERT INTO `tb_user` VALUES (13, '', '13671927745', '86', '5df9acc9bd0da9fecfd9fa3f255f4ca8', '583034', '', '::1', '', '', 1, 1559814722, '', '', '136****7745', '073ecf8fb30ef8d899c', '', 0);
INSERT INTO `tb_user` VALUES (14, '', '13671927746', '86', 'de1b92f5653b3902f7401e5e615e9d92', '907696', '', '::1', '', '', 1, 1561528776, '', '', '136****7746', 'c1239c8f359b1fe688a', '', 0);
INSERT INTO `tb_user` VALUES (20, '', '13671927742', '86', '8e36a9c54c1ff7f1f64c02777931ead2', '200686', '', '::1', '', '', 1, 1561531345, '', '', '136****7742', 'c7fb0072d31dde6f3d2', '', 0);
INSERT INTO `tb_user` VALUES (21, '', '13671927743', '86', 'dd90e2431bbd861df30b9d04af804f24', '782652', '', '::1', '', '', 1, 1561531439, '', '', '136****7743', '6b1342000508246a500', '', 0);
INSERT INTO `tb_user` VALUES (22, '', '13671927732', '86', '1cbe43ff9f931169d0c118f966bd618f', '469919', '', '::1', '', 'e0f912a175d32c2e731080cf00799bdf73776dab', 1, 1561531981, '', '', '136****7739', 'faf874011b16be0fc48', '', 0);
INSERT INTO `tb_user` VALUES (23, '', '', '', 'da261920bb37d7902eef8602d28e85c8', '250729', '', '::1', '', '', 1, 1561533599, '', '', '183****958@qq.com', 'd88c2443fb2cb43f888', '183412924958@qq.com', 1);
INSERT INTO `tb_user` VALUES (25, '', '', '', 'a655589195f3d76fbe9e0409419dde82', '414168', '', '::1', '', '', 1, 1561534903, '', '', '290****717@qq.com', 'cf340f722a3053135d6', '2900882717@qq.com', 1);
INSERT INTO `tb_user` VALUES (27, '', '13671927739', '', '5b0b6b3d6d1b2674e79315d28bdb7251', '550212', '', '::1', '', 'e014014378cb12f7f35390552db6dc171011143e', 1, 1561538006, '', '', '123****qq.com', 'c4acfb68af5708b0961', '123456@qq.com', 1);
INSERT INTO `tb_user` VALUES (28, '', '', '', '3aa37e2fac3a4ac2b6bd8666f2053ff3', '078782', '', '::1', '', '', 1, 1561538430, '', '', '123****q.com', 'ca570c5597d0cc22176', '12356@qq.com', 1);
INSERT INTO `tb_user` VALUES (33, '', '', '', '14f1aa8b201ca3a4e85b48b92f1e12b7', '003139', '', '::1', '', '', 1, 1561538708, '', '', '125****.com', '35c9a721b7de7f79c59', '1256@qq.com', 1);
INSERT INTO `tb_user` VALUES (34, '', '', '', 'edc3e45e8d9d389d5775a6270c0466b9', '574283', '', '::1', '', '', 1, 1561621043, '', '', '126****com', '45d3fe73f10d1a7037e', '126@qq.com', 1);
INSERT INTO `tb_user` VALUES (35, '', '13671927733', '86', 'ac07429c8c287a69b0e43ba888cd77ea', '023504', '', '::1', '', '', 1, 1561621402, '', '', '136****7733', '45abfdc32aa6eea7906', '', 0);
INSERT INTO `tb_user` VALUES (36, '', '', '', '4a40e511b00416ae855e822a5c9b5bef', '675512', '', '::1', '', '', 1, 1562145964, '', '', '123****@qq.com', 'b96dad7ed1be42cedad', '1232256@qq.com', 1);
INSERT INTO `tb_user` VALUES (37, '', '', '', 'c93dcd886509b3546b2c25d228ae355c', '194538', '', '::1', 'static/resource/images/user/007.png', '', 1, 1562912085, '', '', '123****6@qq.com', '', '12342256@qq.com', 1);
INSERT INTO `tb_user` VALUES (38, '', '', '', 'a4c08bea61be8a1fadfe77e9884709d0', '975214', '', '::1', 'static/resource/images/user/003.png', '2505d019ec42dd63db52f86883d30b0753fe7ea8', 1, 1564038750, '', '', '183****958@qq.com', '89df2384fa8b32afab8', '1834924958@qq.com', 1);
INSERT INTO `tb_user` VALUES (39, '', '17839906238', '86', '9969767a1154316cb24605eb88a3e14c', '168683', '', '::1', 'static/resource/images/user/002.png', '98b0aa0db2aa13de696d4d313b01066145fbb3a5', 1, 1564131525, '', '', '178****6238', '1eeaee8d32f7cbd8b21', '', 0);
INSERT INTO `tb_user` VALUES (40, '', '17839906239', '86', '0e9a42144b52b9d9e693097eb65f4f73', '545517', '', '::1', 'static/resource/images/user/.DS_Store', 'f0f4a6c5e9c14cb93cafcd29da8b1381701bd68c', 1, 1564132032, '', '', '178****6239', 'fe9bcf73785e3978996', '', 0);
INSERT INTO `tb_user` VALUES (41, '', '17839906221', '86', '1e005e421716b2aa0a742dadeb94a9e5', '777745', '', '::1', 'static/resource/images/user/006.png', 'f84fe983408fc73b80b0a93c967b0ce1f8ba79b5', 1, 1564132853, '', '', '178****6229', '52c8595f716b345a820', '', 0);
INSERT INTO `tb_user` VALUES (42, '', '1367192749', '', '1cd7483feef0ffa4705b7d1c68ca9e56', '474466', '', '::1', 'static/resource/images/user/006.png', '6ac1f0116402bc04db2277afac539fa1b7c25d64', 1, 1566033020, '', '', '136****7739', '', '', 0);
INSERT INTO `tb_user` VALUES (43, '', '17839906225', '', '9e70ece5ec817f11f5761a68727dfb05', '668088', '', '::1', 'static/resource/images/user/005.png', '', 1, 1566033277, '', '', '178****6225', '', '', 0);
COMMIT;

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
-- Records of tb_user_block
-- ----------------------------
BEGIN;
INSERT INTO `tb_user_block` VALUES (1, 6, '17839906234', 0, 1558494876, '', '', '', '', 0, '', 1558494876, 0, 1);
INSERT INTO `tb_user_block` VALUES (2, 7, '17839906232', 0, 1558495078, '', '', '', '', 0, '', 1558495078, 0, 1);
INSERT INTO `tb_user_block` VALUES (3, 8, '17839906254', 0, 1558495452, '', '', '', '', 0, '', 1558495452, 0, 1);
INSERT INTO `tb_user_block` VALUES (4, 9, '15756261450', 0, 1558609573, '', '', '', '', 0, '', 1558609573, 0, 1);
INSERT INTO `tb_user_block` VALUES (5, 10, '123456', 0, 0, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"123456\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"0cac48d4be5e58b51fc\"}\n', 1, '0cac48d4be5e58b51fc', 0, 1559187888, 1);
INSERT INTO `tb_user_block` VALUES (6, 11, 'asdf1', 0, 1559036019, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"asdf1\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"9fecc7f091e0ad6d809\"}\n', 1, '9fecc7f091e0ad6d809', 1559036019, 1559187888, 1);
INSERT INTO `tb_user_block` VALUES (7, 0, '17839906238', 0, 0, '', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"17839906238\",\"Address\":\"\",\"Nation\":\"\"}', '', '', 0, '', 0, 1559185482, 0);
INSERT INTO `tb_user_block` VALUES (8, 5, '17839906235', 0, 1558495452, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"17839906235\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"b76535a0ae7a86813d1\"}\n', 1, 'b76535a0ae7a86813d1', 1558495452, 1559201779, 1);
INSERT INTO `tb_user_block` VALUES (9, 12, '13671927744', 0, 1559785996, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927744\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"610239b380d9101b9b6\"}\n', 1, '610239b380d9101b9b6', 1559785996, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (10, 13, '13671927745', 0, 1559814722, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927745\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"073ecf8fb30ef8d899c\"}\n', 1, '073ecf8fb30ef8d899c', 1559814722, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (11, 14, '13671927746', 0, 1561528776, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927746\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"c1239c8f359b1fe688a\"}\n', 1, 'c1239c8f359b1fe688a', 1561528776, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (12, 15, '13671927746', 0, 1561528841, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927746\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"6b619d33653d4261aec\"}\n', 1, '6b619d33653d4261aec', 1561528841, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (13, 16, '13671927746', 0, 1561528844, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927746\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"34f7a011ad4afae9f56\"}\n', 1, '34f7a011ad4afae9f56', 1561528844, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (14, 17, '13671927746', 0, 1561528846, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927746\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"fa145f29a272cb769e1\"}\n', 1, 'fa145f29a272cb769e1', 1561528846, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (15, 18, '13671927746', 0, 1561528847, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927746\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"ff0fb55b8d46310808b\"}\n', 1, 'ff0fb55b8d46310808b', 1561528847, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (16, 19, '13671927746', 0, 1561528848, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927746\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"6eb879d8fa7f99754fe\"}\n', 1, '6eb879d8fa7f99754fe', 1561528848, 1562316123, 1);
INSERT INTO `tb_user_block` VALUES (17, 20, '13671927742', 0, 1561531345, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927742\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"c7fb0072d31dde6f3d2\"}\n', 1, 'c7fb0072d31dde6f3d2', 1561531346, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (18, 21, '13671927743', 0, 1561531439, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927743\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"6b1342000508246a500\"}\n', 1, '6b1342000508246a500', 1561531439, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (19, 22, '13671927739', 0, 1561531981, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927739\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"faf874011b16be0fc48\"}\n', 1, 'faf874011b16be0fc48', 1561531981, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (20, 23, '1834924958@qq.com', 1, 1561533599, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"1834924958@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"d88c2443fb2cb43f888\"}\n', 1, 'd88c2443fb2cb43f888', 1561533599, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (22, 25, '2900882717@qq.com', 1, 1561534903, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"2900882717@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"cf340f722a3053135d6\"}\n', 1, 'cf340f722a3053135d6', 1561534903, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (23, 26, '123456@qq.com', 1, 1561537710, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"123456@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"c4e7c14ebb30ffcb920\"}\n', 1, 'c4e7c14ebb30ffcb920', 1561537710, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (24, 27, '123456@qq.com', 1, 1561538006, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"123456@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"c4acfb68af5708b0961\"}\n', 1, 'c4acfb68af5708b0961', 1561538006, 1562583952, 1);
INSERT INTO `tb_user_block` VALUES (25, 28, '12356@qq.com', 1, 1561538430, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"12356@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"ca570c5597d0cc22176\"}\n', 1, 'ca570c5597d0cc22176', 1561538430, 1562316124, 1);
INSERT INTO `tb_user_block` VALUES (30, 33, '1256@qq.com', 1, 1561538708, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"1256@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"35c9a721b7de7f79c59\"}\n', 1, '35c9a721b7de7f79c59', 1561538708, 1562316125, 1);
INSERT INTO `tb_user_block` VALUES (31, 34, '126@qq.com', 1, 1561621043, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"126@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"45d3fe73f10d1a7037e\"}\n', 1, '45d3fe73f10d1a7037e', 1561621043, 1562316125, 1);
INSERT INTO `tb_user_block` VALUES (32, 35, '13671927733', 0, 1561621402, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"13671927733\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"45abfdc32aa6eea7906\"}\n', 1, '45abfdc32aa6eea7906', 1561621402, 1562316125, 1);
INSERT INTO `tb_user_block` VALUES (33, 36, '1232256@qq.com', 1, 1562145964, '文飞墨舞', '{\"Name\":\"\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"1232256@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"Result\":1,\"FailureDescription\":\"\",\"UserGUUID\":\"b96dad7ed1be42cedad\"}\n', 1, 'b96dad7ed1be42cedad', 1562145964, 1562316125, 1);
INSERT INTO `tb_user_block` VALUES (34, 37, '12342256@qq.com', 1, 1562912085, '文飞墨舞', '{\"Name\":\"12342256@qq.com\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"12342256@qq.com\",\"Address\":\"\",\"Nation\":\"\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '404 page not found\n', 0, '', 1562912085, 1564039016, 0);
INSERT INTO `tb_user_block` VALUES (35, 38, '1834924958@qq.com', 1, 1564038750, 'morvooV1.0', '{\"Name\":\"1834924958@qq.com\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"1834924958@qq.com\",\"Address\":\"\",\"Nation\":\"cn\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"ErrCode\":0,\"Msg\":\"user already exist,and update success\",\"UserRegResult\":{\"Did\":\"89df2384fa8b32afab8\",\"RegUser\":{\"Username\":\"1834924958@qq.com\",\"Usertype\":1,\"RegisterationTime\":\"2019-07-25 15:12:30\",\"ProxyPlatformID\":\"morvooV1.0\",\"Person\":{\"Name\":\"1834924958@qq.com\",\"Gender\":0,\"Id\":\"\",\"PhoneNum\":\"1834924958@qq.com\",\"Address\":\"\",\"Nation\":\"cn\"},\"Company\":{\"Name\":\"\",\"CreditCode\":\"\",\"ContactPerson\":\"\",\"ContactPhone\":\"\"}}}}\n', 0, '89df2384fa8b32afab8', 1564038750, 1564126948, 1);
INSERT INTO `tb_user_block` VALUES (37, 39, '17839906238', 0, 1564131525, 'morvooV1.0', '{\"Name\":\"17839906238\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"17839906238\",\"Address\":\"\",\"Nation\":\"cn\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"ErrCode\":0,\"Msg\":\"user already exist,and update success\",\"UserRegResult\":{\"Did\":\"1eeaee8d32f7cbd8b21\",\"RegUser\":{\"Username\":\"17839906238\",\"Usertype\":0,\"RegisterationTime\":\"2019-07-26 16:58:45\",\"ProxyPlatformID\":\"morvooV1.0\",\"Person\":{\"Name\":\"17839906238\",\"Gender\":0,\"Id\":\"\",\"PhoneNum\":\"17839906238\",\"Address\":\"\",\"Nation\":\"cn\"},\"Company\":{\"Name\":\"\",\"CreditCode\":\"\",\"ContactPerson\":\"\",\"ContactPhone\":\"\"}}}}\n', 0, '1eeaee8d32f7cbd8b21', 1564131525, 1564131851, 1);
INSERT INTO `tb_user_block` VALUES (38, 40, '17839906239', 0, 1564132032, '文飞墨舞', '{\"Name\":\"17839906239\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"17839906239\",\"Address\":\"\",\"Nation\":\"cn\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"ErrCode\":0,\"Msg\":\"reg user process success\",\"UserRegResult\":{\"Did\":\"fe9bcf73785e3978996\",\"RegUser\":{\"Username\":\"17839906239\",\"Usertype\":0,\"RegisterationTime\":\"2019-07-26 17:07:12\",\"ProxyPlatformID\":\"文飞墨舞\",\"Person\":{\"Name\":\"17839906239\",\"Gender\":0,\"Id\":\"\",\"PhoneNum\":\"17839906239\",\"Address\":\"\",\"Nation\":\"cn\"},\"Company\":{\"Name\":\"\",\"CreditCode\":\"\",\"ContactPerson\":\"\",\"ContactPhone\":\"\"}}}}\n', 0, 'fe9bcf73785e3978996', 1564132032, 1564563042, 1);
INSERT INTO `tb_user_block` VALUES (39, 41, '17839906221', 0, 1564132853, '文飞墨舞', '{\"Name\":\"17839906221\",\"Gender\":0,\"ID\":\"\",\"PhoneNum\":\"17839906221\",\"Address\":\"\",\"Nation\":\"cn\"}', '{\"Name\":\"\",\"Creditcode\":\"\",\"Contactpersion\":\"\",\"Contactphone\":\"\"}', '{\"ErrCode\":0,\"Msg\":\"user already exist,and update success\",\"UserRegResult\":{\"Did\":\"52c8595f716b345a820\",\"RegUser\":{\"Username\":\"17839906221\",\"Usertype\":0,\"RegisterationTime\":\"2019-07-26 17:20:53\",\"ProxyPlatformID\":\"文飞墨舞\",\"Person\":{\"Name\":\"17839906221\",\"Gender\":0,\"Id\":\"\",\"PhoneNum\":\"17839906221\",\"Address\":\"\",\"Nation\":\"cn\"},\"Company\":{\"Name\":\"\",\"CreditCode\":\"\",\"ContactPerson\":\"\",\"ContactPhone\":\"\"}}}}\n', 0, '52c8595f716b345a820', 1564132853, 1564562951, 1);
INSERT INTO `tb_user_block` VALUES (40, 42, '13671927739', 0, 1566033020, 'morvooV1.0', '{\"name\":\"13671927739\",\"gender\":\"0\",\"id\":\"\",\"phoneNum\":\"13671927739\",\"address\":\"\",\"nation\":\"\"}', '{\"name\":\"\",\"creditCode\":\"\",\"contactPerson\":\"\",\"contactPhone\":\"\"}', '{\"success\":false,\"data\":null,\"msg\":\"system error Index 10 out of bounds for length 10\"}', 0, '', 1566033020, 1566122580, 0);
INSERT INTO `tb_user_block` VALUES (41, 43, '17839906225', 0, 1566033277, 'morvooV1.0', '{\"name\":\"17839906225\",\"gender\":\"0\",\"id\":\"\",\"phoneNum\":\"17839906225\",\"address\":\"\",\"nation\":\"\"}', '{\"name\":\"\",\"creditCode\":\"\",\"contactPerson\":\"\",\"contactPhone\":\"\"}', '{\"success\":false,\"data\":null,\"msg\":\"system error Index 10 out of bounds for length 10\"}', 0, '', 1566033277, 1566122580, 0);
COMMIT;

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
-- Records of tb_user_log
-- ----------------------------
BEGIN;
INSERT INTO `tb_user_log` VALUES (1, 5, 0, 1, '::1', '用户登录', '成功', 1561714241, 1, 1561714241);
INSERT INTO `tb_user_log` VALUES (2, 5, 0, 1, '::1', '用户登录', '成功', 1561714266, 1, 1561714266);
INSERT INTO `tb_user_log` VALUES (3, 27, 1, 1, '::1', '用户登录', '成功', 1561714286, 1, 1561714286);
INSERT INTO `tb_user_log` VALUES (4, 27, 1, 1, '::1', '用户登录', '成功', 1561714339, 1, 1561714339);
INSERT INTO `tb_user_log` VALUES (5, 27, 1, 0, '::1', '用户登录', '成功', 1561714377, 1, 1561714377);
INSERT INTO `tb_user_log` VALUES (6, 27, 1, 0, '::1', '用户登录', '成功', 1561714390, 1, 1561714390);
INSERT INTO `tb_user_log` VALUES (7, 5, 0, 0, '::1', '用户登录', '成功', 1561714402, 1, 1561714402);
INSERT INTO `tb_user_log` VALUES (8, 27, 1, 0, '::1', '用户登录', '成功', 1561716226, 1, 1561716226);
INSERT INTO `tb_user_log` VALUES (9, 27, 1, 0, '::1', '用户登录', '成功', 1561717248, 1, 1561717248);
INSERT INTO `tb_user_log` VALUES (10, 27, 1, 0, '::1', '用户登录', '成功', 1561717370, 1, 1561717370);
INSERT INTO `tb_user_log` VALUES (11, 27, 1, 0, '::1', '用户登录', '成功', 1561717408, 1, 1561717408);
INSERT INTO `tb_user_log` VALUES (12, 22, 0, 0, '::1', '用户登录', '成功', 1561717414, 1, 1561717414);
INSERT INTO `tb_user_log` VALUES (13, 22, 0, 0, '::1', '用户登录', '成功', 1561717435, 1, 1561717435);
INSERT INTO `tb_user_log` VALUES (14, 27, 1, 0, '::1', '用户登录', '成功', 1561717447, 1, 1561717447);
INSERT INTO `tb_user_log` VALUES (15, 27, 1, 0, '::1', '用户登录', '成功', 1561717506, 1, 1561717506);
INSERT INTO `tb_user_log` VALUES (16, 27, 1, 0, '::1', '用户登录', '成功', 1561717511, 1, 1561717511);
INSERT INTO `tb_user_log` VALUES (17, 27, 1, 0, '::1', '用户登录', '成功', 1561717512, 1, 1561717512);
INSERT INTO `tb_user_log` VALUES (18, 27, 1, 0, '::1', '用户登录', '成功', 1561717538, 1, 1561717538);
INSERT INTO `tb_user_log` VALUES (19, 27, 1, 0, '::1', '用户登录', '成功', 1561717541, 1, 1561717541);
INSERT INTO `tb_user_log` VALUES (20, 27, 1, 0, '::1', '用户登录', '成功', 1561717543, 1, 1561717543);
INSERT INTO `tb_user_log` VALUES (21, 27, 1, 0, '::1', '用户登录', '成功', 1561717544, 1, 1561717544);
INSERT INTO `tb_user_log` VALUES (22, 22, 0, 0, '::1', '用户修改密码', '成功', 1561986787, 1, 1561986787);
INSERT INTO `tb_user_log` VALUES (23, 22, 0, 0, '::1', '用户修改密码', '成功', 1561986791, 1, 1561986791);
INSERT INTO `tb_user_log` VALUES (24, 27, 1, 0, '::1', '用户修改密码', '成功', 1561986924, 1, 1561986924);
INSERT INTO `tb_user_log` VALUES (25, 27, 1, 0, '::1', '用户修改密码', '成功', 1561986942, 1, 1561986942);
INSERT INTO `tb_user_log` VALUES (26, 27, 1, 0, '::1', '用户修改密码', '成功', 1561986943, 1, 1561986943);
INSERT INTO `tb_user_log` VALUES (27, 27, 1, 0, '::1', '用户修改密码', '成功', 1561986995, 1, 1561986995);
INSERT INTO `tb_user_log` VALUES (28, 27, 1, 0, '::1', '用户修改密码', '成功', 1561986999, 1, 1561986999);
INSERT INTO `tb_user_log` VALUES (29, 27, 1, 0, '::1', '用户登录', '成功', 1562035612, 1, 1562035612);
INSERT INTO `tb_user_log` VALUES (30, 27, 1, 0, '::1', '用户修改密码', '成功', 1562050790, 1, 1562050790);
INSERT INTO `tb_user_log` VALUES (31, 27, 1, 0, '::1', '用户修改密码', '成功', 1562050823, 1, 1562050823);
INSERT INTO `tb_user_log` VALUES (32, 27, 1, 0, '::1', '用户修改密码', '成功', 1562050858, 1, 1562050858);
INSERT INTO `tb_user_log` VALUES (33, 27, 1, 0, '::1', '用户修改密码', '成功', 1562050990, 1, 1562050990);
INSERT INTO `tb_user_log` VALUES (34, 27, 1, 0, '::1', '用户修改密码', '成功', 1562051000, 1, 1562051000);
INSERT INTO `tb_user_log` VALUES (35, 27, 1, 0, '::1', '用户修改密码', '成功', 1562051003, 1, 1562051003);
INSERT INTO `tb_user_log` VALUES (36, 27, 1, 0, '::1', '个人用户实名认证', '成功', 1562059342, 1, 1562059342);
INSERT INTO `tb_user_log` VALUES (37, 27, 1, 0, '::1', '个人用户实名认证', '成功', 1562059495, 1, 1562059495);
INSERT INTO `tb_user_log` VALUES (38, 27, 1, 0, '::1', '个人用户实名认证', '成功', 1562062112, 1, 1562062112);
INSERT INTO `tb_user_log` VALUES (39, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562062171, 1, 1562062171);
INSERT INTO `tb_user_log` VALUES (40, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562062327, 1, 1562062327);
INSERT INTO `tb_user_log` VALUES (41, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562063920, 1, 1562063920);
INSERT INTO `tb_user_log` VALUES (42, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562063975, 1, 1562063975);
INSERT INTO `tb_user_log` VALUES (43, 27, 0, 0, '::1', '个人用户实名认证', '成功', 1562064099, 1, 1562064099);
INSERT INTO `tb_user_log` VALUES (44, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562064191, 1, 1562064191);
INSERT INTO `tb_user_log` VALUES (45, 27, 0, 0, '::1', '个人用户实名认证', '成功', 1562064255, 1, 1562064255);
INSERT INTO `tb_user_log` VALUES (46, 27, 0, 0, '::1', '个人用户实名认证', '成功', 1562064326, 1, 1562064326);
INSERT INTO `tb_user_log` VALUES (47, 27, 0, 0, '::1', '个人用户实名认证', '成功', 1562064341, 1, 1562064341);
INSERT INTO `tb_user_log` VALUES (48, 27, 0, 0, '::1', '个人用户实名认证', '成功', 1562064385, 1, 1562064385);
INSERT INTO `tb_user_log` VALUES (49, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562064679, 1, 1562064679);
INSERT INTO `tb_user_log` VALUES (50, 27, 1, 0, '::1', '企业用户实名认证', '成功', 1562064714, 1, 1562064714);
INSERT INTO `tb_user_log` VALUES (51, 27, 0, 0, '::1', '个人用户实名认证', '成功', 1562064780, 1, 1562064780);
INSERT INTO `tb_user_log` VALUES (52, 27, 0, 0, '::1', '用户登录', '成功', 1562122547, 1, 1562122547);
INSERT INTO `tb_user_log` VALUES (53, 27, 1, 0, '::1', '用户登录', '成功', 1562125312, 1, 1562125312);
INSERT INTO `tb_user_log` VALUES (54, 27, 1, 0, '::1', '用户登录', '成功', 1562126079, 1, 1562126079);
INSERT INTO `tb_user_log` VALUES (55, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562139207, 1, 1562139207);
INSERT INTO `tb_user_log` VALUES (56, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562139243, 1, 1562139243);
INSERT INTO `tb_user_log` VALUES (57, 27, 1, 0, '::1', '企业用户更新API', '成功', 1562139266, 1, 1562139266);
INSERT INTO `tb_user_log` VALUES (58, 27, 1, 0, '::1', '企业用户更新API', '成功', 1562139360, 1, 1562139360);
INSERT INTO `tb_user_log` VALUES (59, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562139394, 1, 1562139394);
INSERT INTO `tb_user_log` VALUES (60, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562140152, 1, 1562140152);
INSERT INTO `tb_user_log` VALUES (61, 27, 1, 0, '::1', '删除API应用', '成功', 1562141838, 1, 1562141838);
INSERT INTO `tb_user_log` VALUES (62, 27, 1, 0, '::1', '重置API应用', '成功', 1562141880, 1, 1562141880);
INSERT INTO `tb_user_log` VALUES (63, 27, 1, 0, '::1', '重置API应用', '成功', 1562141904, 1, 1562141904);
INSERT INTO `tb_user_log` VALUES (64, 27, 1, 0, '::1', '重置API应用', '成功', 1562142091, 1, 1562142091);
INSERT INTO `tb_user_log` VALUES (65, 27, 1, 0, '::1', '重置API应用', '成功', 1562142111, 1, 1562142111);
INSERT INTO `tb_user_log` VALUES (66, 27, 1, 0, '::1', '重置API应用', '成功', 1562142122, 1, 1562142122);
INSERT INTO `tb_user_log` VALUES (67, 27, 1, 0, '::1', '重置API应用', '成功', 1562142255, 1, 1562142255);
INSERT INTO `tb_user_log` VALUES (68, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562142588, 1, 1562142588);
INSERT INTO `tb_user_log` VALUES (69, 27, 1, 0, '::1', '企业用户更新API', '成功', 1562142596, 1, 1562142596);
INSERT INTO `tb_user_log` VALUES (70, 27, 1, 0, '::1', '企业用户更新API', '成功', 1562142623, 1, 1562142623);
INSERT INTO `tb_user_log` VALUES (71, 27, 1, 0, '::1', '企业用户更新API', '成功', 1562142670, 1, 1562142670);
INSERT INTO `tb_user_log` VALUES (72, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562142694, 1, 1562142694);
INSERT INTO `tb_user_log` VALUES (73, 27, 1, 0, '::1', '重置API应用', '成功', 1562142792, 1, 1562142792);
INSERT INTO `tb_user_log` VALUES (74, 27, 1, 0, '::1', '重置API应用', '成功', 1562142817, 1, 1562142817);
INSERT INTO `tb_user_log` VALUES (75, 27, 1, 0, '::1', '删除API应用', '成功', 1562142828, 1, 1562142828);
INSERT INTO `tb_user_log` VALUES (76, 36, 1, 1, '::1', '用户注册', '成功', 1562145964, 1, 1562145964);
INSERT INTO `tb_user_log` VALUES (77, 22, 0, 0, '::1', '用户登录', '成功', 1562146282, 1, 1562146282);
INSERT INTO `tb_user_log` VALUES (78, 36, 1, 0, '::1', '用户忘记密码', '成功', 1562147580, 1, 1562147580);
INSERT INTO `tb_user_log` VALUES (79, 27, 1, 0, '::1', '用户登录', '成功', 1562205923, 1, 1562205923);
INSERT INTO `tb_user_log` VALUES (80, 27, 1, 0, '::1', '用户修改密码', '成功', 1562207529, 1, 1562207529);
INSERT INTO `tb_user_log` VALUES (81, 27, 1, 0, '::1', '用户修改密码', '成功', 1562207598, 1, 1562207598);
INSERT INTO `tb_user_log` VALUES (82, 27, 1, 0, '::1', '用户修改密码', '成功', 1562207690, 1, 1562207690);
INSERT INTO `tb_user_log` VALUES (83, 27, 0, 0, '::1', '个人用户提交实名认证', '成功', 1562209251, 1, 1562209251);
INSERT INTO `tb_user_log` VALUES (84, 27, 1, 0, '::1', '企业用户创建API', '成功', 1562210615, 1, 1562210615);
INSERT INTO `tb_user_log` VALUES (85, 27, 1, 0, '::1', '重置API应用', '成功', 1562210880, 1, 1562210880);
INSERT INTO `tb_user_log` VALUES (86, 27, 1, 1, '::1', '用户存证', '成功', 1562307851, 1, 1562307851);
INSERT INTO `tb_user_log` VALUES (87, 27, 1, 1, '::1', '用户存证', '成功', 1562307897, 1, 1562307897);
INSERT INTO `tb_user_log` VALUES (88, 27, 1, 1, '::1', '用户存证', '成功', 1562308004, 1, 1562308004);
INSERT INTO `tb_user_log` VALUES (89, 27, 1, 1, '::1', '企业用户存证', '成功', 1562308031, 1, 1562308031);
INSERT INTO `tb_user_log` VALUES (90, 27, 1, 1, '::1', '企业用户存证', '成功', 1562308810, 1, 1562308810);
INSERT INTO `tb_user_log` VALUES (91, 27, 1, 1, '::1', '企业用户存证', '成功', 1562308824, 1, 1562308824);
INSERT INTO `tb_user_log` VALUES (92, 27, 1, 1, '::1', '企业用户存证', '成功', 1562309296, 1, 1562309296);
INSERT INTO `tb_user_log` VALUES (93, 27, 1, 1, '::1', '企业用户存证', '成功', 1562309557, 1, 1562309557);
INSERT INTO `tb_user_log` VALUES (94, 27, 1, 1, '::1', '企业用户存证', '成功', 1562309743, 1, 1562309743);
INSERT INTO `tb_user_log` VALUES (95, 27, 1, 1, '::1', '企业用户存证', '成功', 1562310048, 1, 1562310048);
INSERT INTO `tb_user_log` VALUES (96, 27, 1, 1, '::1', '企业用户存证', '成功', 1562310466, 1, 1562310466);
INSERT INTO `tb_user_log` VALUES (97, 27, 1, 1, '::1', '企业用户存证', '成功', 1562315996, 1, 1562315996);
INSERT INTO `tb_user_log` VALUES (98, 27, 1, 1, '::1', '企业用户存证', '成功', 1562322172, 1, 1562322172);
INSERT INTO `tb_user_log` VALUES (99, 27, 1, 0, '::1', '用户登录', '成功', 1562379380, 1, 1562379380);
INSERT INTO `tb_user_log` VALUES (100, 27, 1, 0, '::1', '用户登录', '成功', 1562379488, 1, 1562379488);
INSERT INTO `tb_user_log` VALUES (101, 27, 1, 0, '::1', '用户登录', '成功', 1562379489, 1, 1562379489);
INSERT INTO `tb_user_log` VALUES (102, 27, 1, 0, '::1', '用户登录', '成功', 1562380729, 1, 1562380729);
INSERT INTO `tb_user_log` VALUES (103, 27, 1, 0, '::1', '用户登录', '成功', 1562381835, 1, 1562381835);
INSERT INTO `tb_user_log` VALUES (104, 27, 1, 0, '::1', '用户登录', '成功', 1562382487, 1, 1562382487);
INSERT INTO `tb_user_log` VALUES (105, 27, 1, 0, '::1', '用户登录', '成功', 1562388336, 1, 1562388336);
INSERT INTO `tb_user_log` VALUES (106, 27, 1, 0, '::1', '用户登录', '成功', 1562555055, 1, 1562555055);
INSERT INTO `tb_user_log` VALUES (107, 27, 1, 0, '::1', '用户登录', '成功', 1562555310, 1, 1562555310);
INSERT INTO `tb_user_log` VALUES (108, 27, 1, 0, '::1', '用户登录', '成功', 1562555312, 1, 1562555312);
INSERT INTO `tb_user_log` VALUES (109, 27, 1, 0, '::1', '用户登录', '成功', 1562555313, 1, 1562555313);
INSERT INTO `tb_user_log` VALUES (110, 27, 1, 0, '::1', '用户登录', '成功', 1562555315, 1, 1562555315);
INSERT INTO `tb_user_log` VALUES (111, 27, 1, 0, '::1', '用户登录', '成功', 1562555316, 1, 1562555316);
INSERT INTO `tb_user_log` VALUES (112, 27, 1, 0, '::1', '用户登录', '成功', 1562555317, 1, 1562555317);
INSERT INTO `tb_user_log` VALUES (113, 27, 1, 0, '::1', '用户登录', '成功', 1562555969, 1, 1562555969);
INSERT INTO `tb_user_log` VALUES (114, 27, 1, 0, '::1', '用户登录', '成功', 1562570949, 1, 1562570949);
INSERT INTO `tb_user_log` VALUES (115, 27, 1, 1, '::1', '企业用户存证', '成功', 1562570969, 1, 1562570969);
INSERT INTO `tb_user_log` VALUES (116, 27, 1, 1, '::1', '企业用户存证', '成功', 1562572461, 1, 1562572461);
INSERT INTO `tb_user_log` VALUES (117, 27, 1, 1, '::1', '企业用户存证', '成功', 1562573634, 1, 1562573634);
INSERT INTO `tb_user_log` VALUES (118, 27, 1, 1, '::1', '企业用户存证', '成功', 1562574642, 1, 1562574642);
INSERT INTO `tb_user_log` VALUES (119, 27, 1, 1, '::1', '企业用户存证', '成功', 1562574817, 1, 1562574817);
INSERT INTO `tb_user_log` VALUES (120, 27, 1, 1, '::1', '企业用户存证', '成功', 1562575180, 1, 1562575180);
INSERT INTO `tb_user_log` VALUES (121, 27, 1, 1, '::1', '企业用户存证', '成功', 1562584012, 1, 1562584012);
INSERT INTO `tb_user_log` VALUES (122, 27, 1, 1, '::1', '企业用户存证', '成功', 1562584780, 1, 1562584780);
INSERT INTO `tb_user_log` VALUES (123, 27, 1, 0, '::1', '用户登录', '成功', 1562659979, 1, 1562659979);
INSERT INTO `tb_user_log` VALUES (124, 27, 1, 0, '::1', '用户登录', '成功', 1562682279, 1, 1562682279);
INSERT INTO `tb_user_log` VALUES (125, 27, 1, 1, '::1', '企业用户存证', '成功', 1562728886, 1, 1562728886);
INSERT INTO `tb_user_log` VALUES (126, 27, 1, 0, '::1', '用户登录', '成功', 1562738540, 1, 1562738540);
INSERT INTO `tb_user_log` VALUES (127, 27, 1, 1, '::1', '企业用户存证', '成功', 1562741378, 1, 1562741378);
INSERT INTO `tb_user_log` VALUES (128, 27, 1, 0, '::1', '用户登录', '成功', 1562758638, 1, 1562758638);
INSERT INTO `tb_user_log` VALUES (129, 27, 1, 0, '::1', '用户登录', '成功', 1562759568, 1, 1562759568);
INSERT INTO `tb_user_log` VALUES (130, 27, 1, 0, '::1', '用户登录', '成功', 1562811868, 1, 1562811868);
INSERT INTO `tb_user_log` VALUES (131, 27, 1, 7, '::1', '企业用户提交维权申请', '成功', 1562827736, 1, 1562827736);
INSERT INTO `tb_user_log` VALUES (132, 27, 1, 4, '::1', '企业用户退出', '成功', 1562829162, 1, 1562829162);
INSERT INTO `tb_user_log` VALUES (133, 27, 1, 0, '::1', '用户登录', '成功', 1562829204, 1, 1562829204);
INSERT INTO `tb_user_log` VALUES (134, 27, 1, 0, '::1', '用户登录', '成功', 1562829752, 1, 1562829752);
INSERT INTO `tb_user_log` VALUES (135, 37, 1, 1, '::1', '用户注册', '成功', 1562912085, 1, 1562912085);
INSERT INTO `tb_user_log` VALUES (136, 27, 1, 0, '::1', '用户登录', '成功', 1563155467, 1, 1563155467);
INSERT INTO `tb_user_log` VALUES (137, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563157377, 1, 1563157377);
INSERT INTO `tb_user_log` VALUES (141, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563159098, 1, 1563159098);
INSERT INTO `tb_user_log` VALUES (142, 27, 1, 0, '::1', '用户登录', '成功', 1563243310, 1, 1563243310);
INSERT INTO `tb_user_log` VALUES (143, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563248812, 1, 1563248812);
INSERT INTO `tb_user_log` VALUES (144, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563248911, 1, 1563248911);
INSERT INTO `tb_user_log` VALUES (145, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563249152, 1, 1563249152);
INSERT INTO `tb_user_log` VALUES (146, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563255064, 1, 1563255064);
INSERT INTO `tb_user_log` VALUES (147, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563255151, 1, 1563255151);
INSERT INTO `tb_user_log` VALUES (148, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563255181, 1, 1563255181);
INSERT INTO `tb_user_log` VALUES (149, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563255271, 1, 1563255271);
INSERT INTO `tb_user_log` VALUES (150, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563255316, 1, 1563255316);
INSERT INTO `tb_user_log` VALUES (151, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563255446, 1, 1563255446);
INSERT INTO `tb_user_log` VALUES (152, 27, 1, 5, '::1', '企业用户存证', '成功', 1563259497, 1, 1563259497);
INSERT INTO `tb_user_log` VALUES (153, 27, 1, 0, '::1', '用户登录', '成功', 1563278927, 1, 1563278927);
INSERT INTO `tb_user_log` VALUES (154, 27, 1, 5, '::1', '企业用户存证', '成功', 1563278965, 1, 1563278965);
INSERT INTO `tb_user_log` VALUES (155, 27, 1, 0, '::1', '用户登录', '成功', 1563352324, 1, 1563352324);
INSERT INTO `tb_user_log` VALUES (156, 27, 1, 5, '::1', '企业用户存证', '成功', 1563352530, 1, 1563352530);
INSERT INTO `tb_user_log` VALUES (157, 27, 1, 0, '::1', '用户登录', '成功', 1563501124, 1, 1563501124);
INSERT INTO `tb_user_log` VALUES (158, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501148, 1, 1563501148);
INSERT INTO `tb_user_log` VALUES (159, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501150, 1, 1563501150);
INSERT INTO `tb_user_log` VALUES (160, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501256, 1, 1563501256);
INSERT INTO `tb_user_log` VALUES (161, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501258, 1, 1563501258);
INSERT INTO `tb_user_log` VALUES (162, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501260, 1, 1563501260);
INSERT INTO `tb_user_log` VALUES (163, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501261, 1, 1563501261);
INSERT INTO `tb_user_log` VALUES (164, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501261, 1, 1563501261);
INSERT INTO `tb_user_log` VALUES (165, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501261, 1, 1563501261);
INSERT INTO `tb_user_log` VALUES (166, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501262, 1, 1563501262);
INSERT INTO `tb_user_log` VALUES (167, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501262, 1, 1563501262);
INSERT INTO `tb_user_log` VALUES (168, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501265, 1, 1563501265);
INSERT INTO `tb_user_log` VALUES (169, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501265, 1, 1563501265);
INSERT INTO `tb_user_log` VALUES (170, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563501392, 1, 1563501392);
INSERT INTO `tb_user_log` VALUES (171, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563501412, 1, 1563501412);
INSERT INTO `tb_user_log` VALUES (172, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563501430, 1, 1563501430);
INSERT INTO `tb_user_log` VALUES (173, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563501436, 1, 1563501436);
INSERT INTO `tb_user_log` VALUES (174, 27, 1, 0, '::1', '用户登录', '成功', 1563503807, 1, 1563503807);
INSERT INTO `tb_user_log` VALUES (175, 27, 1, 0, '::1', '用户登录', '成功', 1563503810, 1, 1563503810);
INSERT INTO `tb_user_log` VALUES (176, 27, 1, 10, '::1', '删除API应用', '成功', 1563506359, 1, 1563506359);
INSERT INTO `tb_user_log` VALUES (177, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563506435, 1, 1563506435);
INSERT INTO `tb_user_log` VALUES (178, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563506442, 1, 1563506442);
INSERT INTO `tb_user_log` VALUES (179, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563506448, 1, 1563506448);
INSERT INTO `tb_user_log` VALUES (180, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563506471, 1, 1563506471);
INSERT INTO `tb_user_log` VALUES (181, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563506504, 1, 1563506504);
INSERT INTO `tb_user_log` VALUES (182, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563506512, 1, 1563506512);
INSERT INTO `tb_user_log` VALUES (183, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563506518, 1, 1563506518);
INSERT INTO `tb_user_log` VALUES (184, 27, 1, 10, '::1', '删除API应用', '成功', 1563506547, 1, 1563506547);
INSERT INTO `tb_user_log` VALUES (185, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563506553, 1, 1563506553);
INSERT INTO `tb_user_log` VALUES (186, 27, 1, 0, '::1', '用户登录', '成功', 1563531189, 1, 1563531189);
INSERT INTO `tb_user_log` VALUES (187, 27, 1, 0, '::1', '用户登录', '成功', 1563587450, 1, 1563587450);
INSERT INTO `tb_user_log` VALUES (188, 27, 1, 8, '::1', '企业用户创建API', '成功', 1563587468, 1, 1563587468);
INSERT INTO `tb_user_log` VALUES (189, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563587643, 1, 1563587643);
INSERT INTO `tb_user_log` VALUES (190, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563587702, 1, 1563587702);
INSERT INTO `tb_user_log` VALUES (191, 27, 1, 12, '::1', '企业用户更新API', '成功', 1563588248, 1, 1563588248);
INSERT INTO `tb_user_log` VALUES (192, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563593401, 1, 1563593401);
INSERT INTO `tb_user_log` VALUES (193, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593413, 1, 1563593413);
INSERT INTO `tb_user_log` VALUES (194, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593416, 1, 1563593416);
INSERT INTO `tb_user_log` VALUES (195, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593417, 1, 1563593417);
INSERT INTO `tb_user_log` VALUES (196, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593417, 1, 1563593417);
INSERT INTO `tb_user_log` VALUES (197, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593417, 1, 1563593417);
INSERT INTO `tb_user_log` VALUES (198, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593418, 1, 1563593418);
INSERT INTO `tb_user_log` VALUES (199, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593432, 1, 1563593432);
INSERT INTO `tb_user_log` VALUES (200, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593433, 1, 1563593433);
INSERT INTO `tb_user_log` VALUES (201, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593433, 1, 1563593433);
INSERT INTO `tb_user_log` VALUES (202, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563593433, 1, 1563593433);
INSERT INTO `tb_user_log` VALUES (203, 22, 0, 0, '::1', '用户登录', '成功', 1563593462, 1, 1563593462);
INSERT INTO `tb_user_log` VALUES (204, 22, 0, 11, '::1', '个人用户提交实名认证', '成功', 1563593500, 1, 1563593500);
INSERT INTO `tb_user_log` VALUES (205, 22, 0, 11, '::1', '个人用户更新实名认证', '成功', 1563593781, 1, 1563593781);
INSERT INTO `tb_user_log` VALUES (206, 22, 0, 0, '::1', '用户登录', '成功', 1563593985, 1, 1563593985);
INSERT INTO `tb_user_log` VALUES (207, 22, 0, 0, '::1', '用户登录', '成功', 1563597147, 1, 1563597147);
INSERT INTO `tb_user_log` VALUES (208, 22, 0, 11, '::1', '个人用户提交实名认证', '成功', 1563597194, 1, 1563597194);
INSERT INTO `tb_user_log` VALUES (209, 22, 0, 11, '::1', '个人用户更新实名认证', '成功', 1563597196, 1, 1563597196);
INSERT INTO `tb_user_log` VALUES (210, 22, 0, 11, '::1', '个人用户更新实名认证', '成功', 1563597309, 1, 1563597309);
INSERT INTO `tb_user_log` VALUES (211, 22, 0, 11, '::1', '个人用户更新实名认证', '成功', 1563597322, 1, 1563597322);
INSERT INTO `tb_user_log` VALUES (212, 1, 0, 0, '::1', '用户登录', '成功', 1563597337, 1, 1563597337);
INSERT INTO `tb_user_log` VALUES (213, 27, 1, 0, '::1', '用户登录', '成功', 1563597381, 1, 1563597381);
INSERT INTO `tb_user_log` VALUES (214, 27, 1, 11, '::1', '企业用户提交实名认证', '成功', 1563597463, 1, 1563597463);
INSERT INTO `tb_user_log` VALUES (215, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1563597466, 1, 1563597466);
INSERT INTO `tb_user_log` VALUES (216, 27, 1, 0, '::1', '用户登录', '成功', 1563599929, 1, 1563599929);
INSERT INTO `tb_user_log` VALUES (217, 1, 0, 0, '::1', '用户登录', '成功', 1563611112, 1, 1563611112);
INSERT INTO `tb_user_log` VALUES (218, 27, 1, 0, '::1', '用户登录', '成功', 1563611244, 1, 1563611244);
INSERT INTO `tb_user_log` VALUES (219, 27, 1, 0, '::1', '用户登录', '成功', 1563783186, 1, 1563783186);
INSERT INTO `tb_user_log` VALUES (220, 38, 1, 1, '::1', '用户注册', '成功', 1564038750, 1, 1564038750);
INSERT INTO `tb_user_log` VALUES (221, 38, 1, 0, '::1', '用户登录', '成功', 1564127186, 1, 1564127186);
INSERT INTO `tb_user_log` VALUES (222, 38, 1, 11, '::1', '企业用户提交实名认证', '成功', 1564127305, 1, 1564127305);
INSERT INTO `tb_user_log` VALUES (223, 38, 1, 5, '::1', '企业用户存证', '成功', 1564127392, 1, 1564127392);
INSERT INTO `tb_user_log` VALUES (224, 38, 1, 5, '::1', '企业用户存证', '成功', 1564128839, 1, 1564128839);
INSERT INTO `tb_user_log` VALUES (225, 39, 0, 1, '::1', '用户注册', '成功', 1564131525, 1, 1564131525);
INSERT INTO `tb_user_log` VALUES (226, 27, 1, 0, '::1', '用户登录', '成功', 1564131537, 1, 1564131537);
INSERT INTO `tb_user_log` VALUES (227, 39, 0, 0, '::1', '用户登录', '成功', 1564131547, 1, 1564131547);
INSERT INTO `tb_user_log` VALUES (228, 40, 0, 1, '::1', '用户注册', '成功', 1564132032, 1, 1564132032);
INSERT INTO `tb_user_log` VALUES (229, 40, 0, 0, '::1', '用户登录', '成功', 1564132041, 1, 1564132041);
INSERT INTO `tb_user_log` VALUES (230, 40, 0, 11, '::1', '个人用户提交实名认证', '成功', 1564132272, 1, 1564132272);
INSERT INTO `tb_user_log` VALUES (231, 40, 0, 5, '::1', '个人用户存证', '成功', 1564132307, 1, 1564132307);
INSERT INTO `tb_user_log` VALUES (232, 41, 0, 1, '::1', '用户注册', '成功', 1564132853, 1, 1564132853);
INSERT INTO `tb_user_log` VALUES (233, 41, 0, 0, '::1', '用户登录', '成功', 1564132862, 1, 1564132862);
INSERT INTO `tb_user_log` VALUES (234, 40, 0, 5, '::1', '个人用户存证', '成功', 1564134245, 1, 1564134245);
INSERT INTO `tb_user_log` VALUES (235, 27, 1, 0, '::1', '用户登录', '成功', 1564372313, 1, 1564372313);
INSERT INTO `tb_user_log` VALUES (236, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1564372452, 1, 1564372449);
INSERT INTO `tb_user_log` VALUES (237, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1564378728, 1, 1564378726);
INSERT INTO `tb_user_log` VALUES (238, 27, 1, 11, '::1', '企业用户更新实名认证', '成功', 1564378923, 1, 1564378921);
INSERT INTO `tb_user_log` VALUES (239, 40, 0, 0, '::1', '用户登录', '成功', 1564563077, 1, 1564563077);
INSERT INTO `tb_user_log` VALUES (240, 40, 0, 5, '::1', '个人用户存证', '成功', 1564563107, 1, 1564563107);
INSERT INTO `tb_user_log` VALUES (241, 27, 1, 0, '::1', '用户登录', '成功', 1566030998, 1, 1566030998);
INSERT INTO `tb_user_log` VALUES (242, 27, 1, 0, '::1', '用户登录', '成功', 1566031388, 1, 1566031388);
INSERT INTO `tb_user_log` VALUES (243, 27, 1, 4, '::1', '企业用户退出', '成功', 1566031454, 1, 1566031454);
INSERT INTO `tb_user_log` VALUES (244, 42, 0, 1, '::1', '用户注册', '成功', 1566033020, 1, 1566033020);
INSERT INTO `tb_user_log` VALUES (245, 43, 0, 1, '::1', '用户注册', '成功', 1566033277, 1, 1566033277);
INSERT INTO `tb_user_log` VALUES (246, 42, 0, 0, '::1', '用户登录', '成功', 1566033367, 1, 1566033367);
INSERT INTO `tb_user_log` VALUES (247, 42, 0, 0, '::1', '用户登录', '成功', 1566033370, 1, 1566033370);
INSERT INTO `tb_user_log` VALUES (248, 39, 0, 0, '::1', '用户登录', '成功', 1566033378, 1, 1566033378);
INSERT INTO `tb_user_log` VALUES (249, 42, 0, 0, '::1', '用户登录', '成功', 1566033574, 1, 1566033574);
INSERT INTO `tb_user_log` VALUES (250, 42, 0, 4, '::1', '个人用户退出', '成功', 1566033595, 1, 1566033595);
INSERT INTO `tb_user_log` VALUES (251, 42, 0, 0, '::1', '用户登录', '成功', 1566038645, 1, 1566038645);
INSERT INTO `tb_user_log` VALUES (252, 27, 1, 0, '::1', '用户登录', '成功', 1566038794, 1, 1566038794);
INSERT INTO `tb_user_log` VALUES (253, 27, 1, 5, '::1', '用户存证', '成功', 1566040827, 1, 1566040827);
INSERT INTO `tb_user_log` VALUES (254, 27, 1, 5, '::1', '用户存证', '成功', 1566111753, 1, 1566111753);
COMMIT;

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
-- Records of tb_user_login
-- ----------------------------
BEGIN;
INSERT INTO `tb_user_login` VALUES (1, 5, '::1', 1561713829);
INSERT INTO `tb_user_login` VALUES (2, 5, '::1', 1561713841);
INSERT INTO `tb_user_login` VALUES (3, 5, '::1', 1561713842);
INSERT INTO `tb_user_login` VALUES (4, 5, '::1', 1561713867);
INSERT INTO `tb_user_login` VALUES (5, 5, '::1', 1561714241);
INSERT INTO `tb_user_login` VALUES (6, 5, '::1', 1561714266);
INSERT INTO `tb_user_login` VALUES (7, 27, '::1', 1561714286);
INSERT INTO `tb_user_login` VALUES (8, 27, '::1', 1561714339);
INSERT INTO `tb_user_login` VALUES (9, 27, '::1', 1561714377);
INSERT INTO `tb_user_login` VALUES (10, 27, '::1', 1561714390);
INSERT INTO `tb_user_login` VALUES (11, 5, '::1', 1561714402);
INSERT INTO `tb_user_login` VALUES (12, 27, '::1', 1561716226);
INSERT INTO `tb_user_login` VALUES (13, 27, '::1', 1561717248);
INSERT INTO `tb_user_login` VALUES (14, 27, '::1', 1561717370);
INSERT INTO `tb_user_login` VALUES (15, 27, '::1', 1561717408);
INSERT INTO `tb_user_login` VALUES (16, 22, '::1', 1561717414);
INSERT INTO `tb_user_login` VALUES (17, 22, '::1', 1561717435);
INSERT INTO `tb_user_login` VALUES (18, 27, '::1', 1561717447);
INSERT INTO `tb_user_login` VALUES (19, 27, '::1', 1561717506);
INSERT INTO `tb_user_login` VALUES (20, 27, '::1', 1561717511);
INSERT INTO `tb_user_login` VALUES (21, 27, '::1', 1561717512);
INSERT INTO `tb_user_login` VALUES (22, 27, '::1', 1561717538);
INSERT INTO `tb_user_login` VALUES (23, 27, '::1', 1561717541);
INSERT INTO `tb_user_login` VALUES (24, 27, '::1', 1561717543);
INSERT INTO `tb_user_login` VALUES (25, 27, '::1', 1561717544);
INSERT INTO `tb_user_login` VALUES (26, 27, '::1', 1562035612);
INSERT INTO `tb_user_login` VALUES (27, 27, '::1', 1562122547);
INSERT INTO `tb_user_login` VALUES (28, 27, '::1', 1562125312);
INSERT INTO `tb_user_login` VALUES (29, 27, '::1', 1562126079);
INSERT INTO `tb_user_login` VALUES (30, 22, '::1', 1562146282);
INSERT INTO `tb_user_login` VALUES (31, 27, '::1', 1562205923);
INSERT INTO `tb_user_login` VALUES (32, 27, '::1', 1562379380);
INSERT INTO `tb_user_login` VALUES (33, 27, '::1', 1562379488);
INSERT INTO `tb_user_login` VALUES (34, 27, '::1', 1562379489);
INSERT INTO `tb_user_login` VALUES (35, 27, '::1', 1562380729);
INSERT INTO `tb_user_login` VALUES (36, 27, '::1', 1562381835);
INSERT INTO `tb_user_login` VALUES (37, 27, '::1', 1562382487);
INSERT INTO `tb_user_login` VALUES (38, 27, '::1', 1562388336);
INSERT INTO `tb_user_login` VALUES (39, 27, '::1', 1562555055);
INSERT INTO `tb_user_login` VALUES (40, 27, '::1', 1562555310);
INSERT INTO `tb_user_login` VALUES (41, 27, '::1', 1562555312);
INSERT INTO `tb_user_login` VALUES (42, 27, '::1', 1562555313);
INSERT INTO `tb_user_login` VALUES (43, 27, '::1', 1562555315);
INSERT INTO `tb_user_login` VALUES (44, 27, '::1', 1562555316);
INSERT INTO `tb_user_login` VALUES (45, 27, '::1', 1562555317);
INSERT INTO `tb_user_login` VALUES (46, 27, '::1', 1562555969);
INSERT INTO `tb_user_login` VALUES (47, 27, '::1', 1562570949);
INSERT INTO `tb_user_login` VALUES (48, 27, '::1', 1562659979);
INSERT INTO `tb_user_login` VALUES (49, 27, '::1', 1562682279);
INSERT INTO `tb_user_login` VALUES (50, 27, '::1', 1562738540);
INSERT INTO `tb_user_login` VALUES (51, 27, '::1', 1562758638);
INSERT INTO `tb_user_login` VALUES (52, 27, '::1', 1562759568);
INSERT INTO `tb_user_login` VALUES (53, 27, '::1', 1562811868);
INSERT INTO `tb_user_login` VALUES (54, 27, '::1', 1562829204);
INSERT INTO `tb_user_login` VALUES (55, 27, '::1', 1562829752);
INSERT INTO `tb_user_login` VALUES (56, 27, '::1', 1563155467);
INSERT INTO `tb_user_login` VALUES (57, 27, '::1', 1563243310);
INSERT INTO `tb_user_login` VALUES (58, 27, '::1', 1563278927);
INSERT INTO `tb_user_login` VALUES (59, 27, '::1', 1563352324);
INSERT INTO `tb_user_login` VALUES (60, 27, '::1', 1563501124);
INSERT INTO `tb_user_login` VALUES (61, 27, '::1', 1563503807);
INSERT INTO `tb_user_login` VALUES (62, 27, '::1', 1563503810);
INSERT INTO `tb_user_login` VALUES (63, 27, '::1', 1563531189);
INSERT INTO `tb_user_login` VALUES (64, 27, '::1', 1563587450);
INSERT INTO `tb_user_login` VALUES (65, 22, '::1', 1563593462);
INSERT INTO `tb_user_login` VALUES (66, 22, '::1', 1563593985);
INSERT INTO `tb_user_login` VALUES (67, 22, '::1', 1563597147);
INSERT INTO `tb_user_login` VALUES (68, 1, '::1', 1563597337);
INSERT INTO `tb_user_login` VALUES (69, 27, '::1', 1563597381);
INSERT INTO `tb_user_login` VALUES (70, 27, '::1', 1563599929);
INSERT INTO `tb_user_login` VALUES (71, 1, '::1', 1563611112);
INSERT INTO `tb_user_login` VALUES (72, 27, '::1', 1563611244);
INSERT INTO `tb_user_login` VALUES (73, 27, '::1', 1563783186);
INSERT INTO `tb_user_login` VALUES (74, 38, '::1', 1564127186);
INSERT INTO `tb_user_login` VALUES (75, 27, '::1', 1564131537);
INSERT INTO `tb_user_login` VALUES (76, 39, '::1', 1564131547);
INSERT INTO `tb_user_login` VALUES (77, 40, '::1', 1564132041);
INSERT INTO `tb_user_login` VALUES (78, 41, '::1', 1564132862);
INSERT INTO `tb_user_login` VALUES (79, 27, '::1', 1564372313);
INSERT INTO `tb_user_login` VALUES (80, 40, '::1', 1564563077);
INSERT INTO `tb_user_login` VALUES (81, 27, '::1', 1566030998);
INSERT INTO `tb_user_login` VALUES (82, 27, '::1', 1566031388);
INSERT INTO `tb_user_login` VALUES (83, 42, '::1', 1566033367);
INSERT INTO `tb_user_login` VALUES (84, 42, '::1', 1566033370);
INSERT INTO `tb_user_login` VALUES (85, 39, '::1', 1566033378);
INSERT INTO `tb_user_login` VALUES (86, 42, '::1', 1566033574);
INSERT INTO `tb_user_login` VALUES (87, 42, '::1', 1566038645);
INSERT INTO `tb_user_login` VALUES (88, 27, '::1', 1566038794);
COMMIT;

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
-- Records of tb_user_obligee
-- ----------------------------
BEGIN;
INSERT INTO `tb_user_obligee` VALUES (1, 5, '晨曦1', 1, '412826199612082345', 1558423493, 0);
INSERT INTO `tb_user_obligee` VALUES (3, 5, '晨曦2', 1, '412826199612082346', 1558424034, 0);
INSERT INTO `tb_user_obligee` VALUES (4, 5, '晨曦3', 1, '412826199506053114', 1558424823, 0);
INSERT INTO `tb_user_obligee` VALUES (5, 1, '叶子', 1, '412826199506053134', 1558578846, 0);
INSERT INTO `tb_user_obligee` VALUES (6, 0, '晨曦', 0, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (9, 0, '', 0, '', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (10, 0, '', 0, '', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (11, 5, '晨曦2', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (12, 5, '晨曦3', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (13, 0, '', 0, '', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (14, 0, '', 0, '', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (15, 5, '晨曦2', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (16, 5, '晨曦3', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (17, 5, '晨曦2', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (18, 5, '晨曦3', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (19, 5, '晨曦2', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (20, 5, '晨曦3', 1, '412826199506053118', 0, 0);
INSERT INTO `tb_user_obligee` VALUES (21, 5, '晨曦2', 1, '412826199506053118', 1559022288, 0);
INSERT INTO `tb_user_obligee` VALUES (22, 5, '晨曦3', 1, '412826199506053118', 1559022288, 0);
INSERT INTO `tb_user_obligee` VALUES (23, 5, '晨曦2', 1, '412826199506053118', 1559022893, 45);
INSERT INTO `tb_user_obligee` VALUES (24, 5, '晨曦3', 1, '412826199506053118', 1559022893, 45);
INSERT INTO `tb_user_obligee` VALUES (25, 5, '晨曦2', 1, '412826199506053118', 1559023070, 46);
INSERT INTO `tb_user_obligee` VALUES (26, 5, '晨曦3', 1, '412826199506053118', 1559023070, 46);
INSERT INTO `tb_user_obligee` VALUES (27, 5, '晨曦2', 1, '412826199506053118', 1559024000, 47);
INSERT INTO `tb_user_obligee` VALUES (28, 5, '晨曦3', 1, '412826199506053118', 1559024000, 47);
INSERT INTO `tb_user_obligee` VALUES (29, 5, '晨曦2', 1, '412826199506053118', 1559024098, 48);
INSERT INTO `tb_user_obligee` VALUES (30, 5, '晨曦3', 1, '412826199506053118', 1559024098, 48);
INSERT INTO `tb_user_obligee` VALUES (31, 5, '晨曦2', 1, '412826199506053118', 1559024099, 49);
INSERT INTO `tb_user_obligee` VALUES (32, 5, '晨曦3', 1, '412826199506053118', 1559024099, 49);
INSERT INTO `tb_user_obligee` VALUES (33, 5, '晨曦2', 1, '412826199506053118', 1559024100, 0);
INSERT INTO `tb_user_obligee` VALUES (34, 5, '晨曦3', 1, '412826199506053118', 1559024100, 50);
INSERT INTO `tb_user_obligee` VALUES (35, 5, '晨曦2', 1, '412826199506053118', 1559182073, 51);
INSERT INTO `tb_user_obligee` VALUES (36, 5, '晨曦3', 1, '412826199506053118', 1559182073, 51);
INSERT INTO `tb_user_obligee` VALUES (37, 5, '晨曦2', 1, '412826199506053118', 1559182570, 52);
INSERT INTO `tb_user_obligee` VALUES (38, 5, '晨曦3', 1, '412826199506053118', 1559182570, 52);
INSERT INTO `tb_user_obligee` VALUES (39, 5, '晨曦2', 1, '412826199506053118', 1559544058, 53);
INSERT INTO `tb_user_obligee` VALUES (40, 5, '晨曦3', 1, '412826199506053118', 1559544058, 53);
INSERT INTO `tb_user_obligee` VALUES (41, 5, '晨曦2', 1, '412826199506053118', 1559544774, 54);
INSERT INTO `tb_user_obligee` VALUES (42, 5, '晨曦3', 1, '412826199506053118', 1559544774, 54);
INSERT INTO `tb_user_obligee` VALUES (43, 27, '晨曦', 1, '412826199506053115', 1562220506, 55);
INSERT INTO `tb_user_obligee` VALUES (44, 27, '2019-7-02~2029-07-02', 0, '', 1562307851, 0);
INSERT INTO `tb_user_obligee` VALUES (45, 27, '叶子', 0, '', 1562307897, 0);
INSERT INTO `tb_user_obligee` VALUES (46, 27, '叶子', 0, '', 1562308004, 0);
INSERT INTO `tb_user_obligee` VALUES (47, 27, '叶子', 0, '', 1562308031, 0);
INSERT INTO `tb_user_obligee` VALUES (48, 27, '叶子', 0, '', 1562308810, 0);
INSERT INTO `tb_user_obligee` VALUES (49, 27, '叶子', 0, '', 1562308824, 0);
INSERT INTO `tb_user_obligee` VALUES (50, 27, '叶子', 0, '', 1562309296, 0);
INSERT INTO `tb_user_obligee` VALUES (51, 27, '叶子', 0, '', 1562309557, 0);
INSERT INTO `tb_user_obligee` VALUES (52, 27, '叶子', 0, '', 1562309743, 0);
INSERT INTO `tb_user_obligee` VALUES (53, 27, '叶子', 0, '', 1562310048, 0);
INSERT INTO `tb_user_obligee` VALUES (57, 27, '叶子', 0, '', 1562310466, 0);
INSERT INTO `tb_user_obligee` VALUES (58, 27, '叶子', 0, '', 1562315996, 0);
INSERT INTO `tb_user_obligee` VALUES (59, 27, '叶子', 0, '', 1562322172, 0);
INSERT INTO `tb_user_obligee` VALUES (60, 27, '叶子', 0, '', 1562570969, 0);
INSERT INTO `tb_user_obligee` VALUES (61, 27, '叶子', 0, '', 1562572461, 69);
INSERT INTO `tb_user_obligee` VALUES (62, 27, '叶子', 0, '', 1562573634, 70);
INSERT INTO `tb_user_obligee` VALUES (63, 27, '叶子', 0, '', 1562574642, 71);
INSERT INTO `tb_user_obligee` VALUES (64, 27, '叶子', 0, '', 1562574817, 72);
INSERT INTO `tb_user_obligee` VALUES (65, 27, '叶子', 0, '', 1562575180, 73);
INSERT INTO `tb_user_obligee` VALUES (66, 27, '叶子', 0, '', 1562584012, 74);
INSERT INTO `tb_user_obligee` VALUES (67, 27, '叶子', 0, '', 1562584780, 75);
INSERT INTO `tb_user_obligee` VALUES (68, 27, '叶子', 0, '', 1562728886, 76);
INSERT INTO `tb_user_obligee` VALUES (69, 27, '晨曦', 0, '', 1562741378, 77);
INSERT INTO `tb_user_obligee` VALUES (70, 27, '叶子', 0, '', 1563259497, 78);
INSERT INTO `tb_user_obligee` VALUES (71, 27, '叶子', 0, '', 1563278965, 79);
INSERT INTO `tb_user_obligee` VALUES (72, 27, '在《菜根谭》一书中有话说:人情反复，世路崎岖。行不去处，须知退一步之法；行得去处，务加三分之功，大致的意思是：人间世情反复无常，人生之路崎岖不平，在人生道路上有走不通的地方，要知道退让一步的道理，在走的过去的地方，也一定 要给予人间三分的便利，这样才能逢凶化吉，一帆风顺', 0, '', 1563352530, 80);
INSERT INTO `tb_user_obligee` VALUES (73, 38, '叶子', 0, '', 1564127392, 81);
INSERT INTO `tb_user_obligee` VALUES (74, 38, '叶子', 0, '', 1564128839, 82);
INSERT INTO `tb_user_obligee` VALUES (75, 40, '叶子', 0, '', 1564132307, 83);
INSERT INTO `tb_user_obligee` VALUES (76, 40, '叶子', 0, '', 1564134245, 84);
INSERT INTO `tb_user_obligee` VALUES (77, 40, '叶子', 0, '', 1564563107, 85);
INSERT INTO `tb_user_obligee` VALUES (78, 27, '叶子', 0, '', 1566040827, 86);
INSERT INTO `tb_user_obligee` VALUES (79, 27, '叶子', 0, '', 1566111753, 87);
COMMIT;

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
-- Records of tb_works
-- ----------------------------
BEGIN;
INSERT INTO `tb_works` VALUES (1, 5, 3, '晨曦1', 'ye209mx', 17, 1, 'aaaaaa晨曦', 1558444717, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (2, 1, 3, '晨曦', 'ye209mx', 43, 1, 'aaaaaa晨曦', 1558491988, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (3, 27, 3, '晨曦', 'ye209mx', 43, 1, 'aaaaaa晨曦aaaww', 1558493125, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (4, 5, 3, '晨曦', 'ye209mx', 43, 1, 'aaaaaa晨曦aaaww', 1558495552, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (5, 5, 3, '晨曦', 'ye209mx', 17, 1, 'aaaaaa晨曦aaaww', 1558495600, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (6, 5, 3, '晨曦', 'ye209mx', 23, 1, 'aaaaaa晨曦aaaww', 1558507094, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (7, 5, 3, '晨曦', 'ye209mx', 23, 1, 'aaaaaa晨曦aaaww', 1558515200, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (8, 27, 3, '晨曦1', 'ye209mx', 35, 1, 'aaaaaa晨曦aaaww', 1558516633, 1, 0, '', 'static/upload/videos/20190522/WX6K2emj.mov', 2, '');
INSERT INTO `tb_works` VALUES (9, 5, 3, '晨曦', 'ye209mx', 17, 1, 'aaaaaa晨曦aaaww', 1558518403, 1, 0, '222', 'static/upload/videos/20190522/WX6K2emj.mov', 2, '');
INSERT INTO `tb_works` VALUES (10, 5, 3, '晨曦', 'ye209mx', 17, 1, 'aaaaaa晨曦aaaww', 1558518659, 1, 0, '', 'static/upload/videos/20190522/WX6K2emj.mov', 1, '');
INSERT INTO `tb_works` VALUES (11, 5, 3, '晨曦', 'ye209mx', 17, 1, 'aaaaaa晨曦aaaww', 1558518788, 1, 0, 'static/upload/videos/20190522/WX6K2emj.mov', 'static/upload/videos/20190522/wSftxAxD.mov', 1, '');
INSERT INTO `tb_works` VALUES (12, 1, 5, '晨曦', 'ye209mx', 17, 1, 'aaaaaa晨曦aaaww', 1558579083, 1, 1558579083, '', 'static/upload/videos/20190523/MdqJCKtl.mov', 1, '');
INSERT INTO `tb_works` VALUES (42, 5, 3, '1', 'ye209mx', 17, 1, '1111111', 1558938054, 1, 0, '', '20,21', 2, '');
INSERT INTO `tb_works` VALUES (43, 5, 3, '晨曦3', 'ye209mx', 17, 1, '1111111', 1558938665, 1, 0, '', '22', 2, '');
INSERT INTO `tb_works` VALUES (44, 5, 3, '晨曦4', 'ye209mx', 17, 1, '1111111', 1558938888, 1, 1558938054, '', '8,9', 2, '');
INSERT INTO `tb_works` VALUES (45, 5, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559022893, 1, 0, '', '7,9', 2, '');
INSERT INTO `tb_works` VALUES (46, 5, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559023070, 1, 1559273334, 'static/upload/images/20190525/0423.png', '15', 2, '');
INSERT INTO `tb_works` VALUES (47, 5, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559024000, 1, 0, '', '6,2', 2, '');
INSERT INTO `tb_works` VALUES (48, 27, 0, '晨曦', 'ye209mx', 23, 1, '1111111', 1559024098, 1, 0, '', '6,2', 2, '');
INSERT INTO `tb_works` VALUES (49, 5, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559024099, 1, 0, '', '6,2', 2, '');
INSERT INTO `tb_works` VALUES (50, 5, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559024100, 1, 0, '', '6,2', 2, '');
INSERT INTO `tb_works` VALUES (51, 27, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559182073, 1, 1559206984, '', '27,', 2, '');
INSERT INTO `tb_works` VALUES (52, 27, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1559182570, 1, 0, '', '1', 2, '');
INSERT INTO `tb_works` VALUES (54, 27, 0, '晨曦', 'ye209mx', 0, 1, '1111111', 1559544774, 1, 1559807108, 'static/resource/copyright/20190606/WYmXyCF5.png', '47', 2, '');
INSERT INTO `tb_works` VALUES (55, 27, 0, '晨曦', 'ye209mx', 17, 1, '1111111', 1562220506, 1, 1562316159, 'static/resource/copyright/20190705/2zdJmEAo.png', '8,9', 2, '');
INSERT INTO `tb_works` VALUES (60, 27, 52, '晨曦12', '梵高', 43, 0, '', 1562309743, 1, 0, '', '60', 0, '');
INSERT INTO `tb_works` VALUES (66, 27, 58, '晨曦', '梵高', 43, 0, '', 1562315996, 1, 0, '', '61,62', 0, '');
INSERT INTO `tb_works` VALUES (67, 27, 59, '晨曦', '梵高', 43, 0, '', 1562322172, 1, 0, '', '63', 0, '');
INSERT INTO `tb_works` VALUES (68, 27, 60, '测试', '梵高', 43, 0, '', 1562570969, 1, 0, '', '70', 0, '');
INSERT INTO `tb_works` VALUES (69, 27, 61, '测试111', '梵高', 43, 0, '', 1562572461, 1, 1562572528, 'static/resource/copyright/20190708/FYE5he0J.png', '71', 0, '');
INSERT INTO `tb_works` VALUES (70, 27, 62, '测试23', '梵高', 43, 0, '', 1562573634, 1, 1562573656, 'static/resource/copyright/20190708/sWGs192c.png', '69', 0, 'static/resource/copyright/pc/20190708/8CyUbKpr.png');
INSERT INTO `tb_works` VALUES (71, 27, 63, '测试23111', '梵高', 43, 0, '', 1562574642, 1, 1562574689, 'static/resource/copyright/20190708/7qfcJeiE.png', '64', 0, 'static/resource/copyright/pc/20190708/femo43su.png');
INSERT INTO `tb_works` VALUES (72, 27, 64, '测试23sasa', '梵高', 43, 0, '', 1562574817, 1, 1562574851, 'static/resource/copyright/20190708/DDreG00p.png', '72,73', 0, 'static/resource/copyright/pc/20190708/B9wNeaAI.png');
INSERT INTO `tb_works` VALUES (73, 27, 65, '测试23sasa', '梵高', 43, 0, '', 1562575180, 1, 1562575259, 'static/resource/copyright/20190708/mMshwEWd.png', '74,75', 0, 'static/resource/copyright/pc/20190708/wWaLtO7F.png');
INSERT INTO `tb_works` VALUES (74, 27, 66, '晨曦', '梵高', 43, 0, '', 1562584012, 1, 1562584046, 'static/resource/copyright/20190708/U7v2augT.png', '76', 0, 'static/resource/copyright/pc/20190708/d8kS1KBy.png');
INSERT INTO `tb_works` VALUES (75, 27, 67, '晨曦', '梵高', 43, 0, '', 1562584780, 1, 1562584802, 'static/resource/copyright/20190708/jPKHTFt9.png', '77', 0, 'static/resource/copyright/pc/20190708/uH9XKx4e.png');
INSERT INTO `tb_works` VALUES (76, 27, 68, '晨曦', '梵高', 43, 0, '', 1562728886, 1, 1562728916, 'static/resource/copyright/20190710/Lvy9OwYa.png', '171,172,173', 0, 'static/resource/copyright/pc/20190710/BLa4XuXX.png');
INSERT INTO `tb_works` VALUES (77, 27, 69, '视频监测', '梵高', 17, 0, '', 1562741378, 1, 1562741396, 'static/resource/copyright/20190710/bGLCxM3k.png', '174', 0, 'static/resource/copyright/pc/20190710/CIzxYaoG.png');
INSERT INTO `tb_works` VALUES (78, 27, 70, '测试图片', '晨曦世界', 43, 0, '', 1563259497, 1, 1563259525, 'static/resource/copyright/20190716/e0FAYY17.png', '190,191', 0, 'static/resource/copyright/pc/20190716/6zeEiR67.png');
INSERT INTO `tb_works` VALUES (79, 27, 71, '晨曦', '梵高', 43, 0, '', 1563278965, 1, 1563278972, 'static/resource/copyright/20190716/MWEi2PHZ.png', '189', 0, 'static/resource/copyright/pc/20190716/dcp6Wd5g.png');
INSERT INTO `tb_works` VALUES (80, 27, 72, '中国文化所讲的人情是指人与人之间的性情。人情这两个字，现在解释来看，包括了社会学，政治学，心理学，行为学等等学问都在内，也可以理解为人与人之间融洽相处的感情。世故就是透彻了解事物，懂得过去，现在，未来。故是事情，世故就是世界上这些事情，要懂得人，要懂得事，就叫做人情世故', '世上没有永远的朋友，也没有永远的敌人，只有永远的利益。人与人交往的本质是利益与利益的交换。如果不懂得利益的交换规则，凡是好处自己独吞，那么即使是惊世的才华也会沦为无用的白纸。如果学点分享主义，好处利益分给别人，让每个人的心理得到平衡，那么大家多多少少会通力合作，协助你顺利成功', 43, 0, '', 1563352530, 3, 1563352590, 'static/resource/copyright/20190717/GXAWUN7o.png', '188', 0, 'static/resource/copyright/pc/20190717/p3MernEQ.png');
INSERT INTO `tb_works` VALUES (81, 38, 73, '晨曦', '梵高', 43, 0, '', 1564127392, 1, 1564128713, 'static/resource/copyright/20190726/RZ140YJE.png', '76', 0, 'static/resource/copyright/pc/20190726/9TBEnG3m.png');
INSERT INTO `tb_works` VALUES (82, 38, 74, '晨曦', '梵高', 43, 0, '', 1564128839, 1, 1564128899, 'static/resource/copyright/20190726/k0ZwJY8u.png', '193', 0, 'static/resource/copyright/pc/20190726/iYKN0kZ1.png');
INSERT INTO `tb_works` VALUES (83, 40, 75, '晨曦', '梵高', 43, 0, '', 1564132307, 1, 1564132344, 'static/resource/copyright/20190726/9ukCyc6A.png', '195', 0, 'static/resource/copyright/pc/20190726/cLI6y6S9.png');
INSERT INTO `tb_works` VALUES (84, 40, 76, '晨曦', '梵高', 43, 0, '', 1564134245, 1, 1564134256, 'static/resource/copyright/20190726/xY55cZ6U.png', '196', 0, 'static/resource/copyright/pc/20190726/s7lMSAke.png');
INSERT INTO `tb_works` VALUES (85, 40, 77, '晨曦', '梵高', 43, 0, '', 1564563107, 1, 1564563136, 'static/resource/copyright/20190731/yroy53BR.png', '198', 0, 'static/resource/copyright/pc/20190731/2sYuZnW2.png');
INSERT INTO `tb_works` VALUES (86, 27, 78, '晨曦', '梵高', 17, 0, '', 1566040827, 3, 1566136732, 'static/resource/copyright/pc/20190818/LymWcxbd.png', '202', 0, 'static/resource/copyright/pc/20190818/LymWcxbd.png');
INSERT INTO `tb_works` VALUES (87, 27, 79, '晨曦', '梵高', 17, 0, '', 1566111753, 3, 1566111893, 'static/resource/copyright/20190818/e6P0NZro.png', '201', 0, 'static/resource/copyright/pc/20190818/6QsOvBpN.png');
COMMIT;

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
-- Records of tb_works_copyright
-- ----------------------------
BEGIN;
INSERT INTO `tb_works_copyright` VALUES (1, 5, 3, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558493125, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558493125, 0);
INSERT INTO `tb_works_copyright` VALUES (2, 5, 4, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558495552, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558495552, 0);
INSERT INTO `tb_works_copyright` VALUES (3, 5, 5, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558495600, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558495600, 0);
INSERT INTO `tb_works_copyright` VALUES (4, 5, 6, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558507094, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558507094, 0);
INSERT INTO `tb_works_copyright` VALUES (5, 5, 7, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558515200, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558515200, 0);
INSERT INTO `tb_works_copyright` VALUES (6, 27, 8, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558516634, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558516634, 0);
INSERT INTO `tb_works_copyright` VALUES (7, 5, 9, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558518403, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558518403, 0);
INSERT INTO `tb_works_copyright` VALUES (8, 5, 10, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558518659, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558518659, 0);
INSERT INTO `tb_works_copyright` VALUES (9, 5, 11, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558518788, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558518788, 0);
INSERT INTO `tb_works_copyright` VALUES (10, 1, 12, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558579083, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558579083, 0);
INSERT INTO `tb_works_copyright` VALUES (11, 5, 13, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558863142, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558863142, 0);
INSERT INTO `tb_works_copyright` VALUES (12, 5, 14, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558863343, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558863343, 0);
INSERT INTO `tb_works_copyright` VALUES (13, 5, 15, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558863730, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558863730, 0);
INSERT INTO `tb_works_copyright` VALUES (14, 5, 16, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558863801, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558863801, 0);
INSERT INTO `tb_works_copyright` VALUES (15, 5, 17, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558865102, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558865102, 0);
INSERT INTO `tb_works_copyright` VALUES (16, 5, 18, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558867164, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558867164, 0);
INSERT INTO `tb_works_copyright` VALUES (17, 5, 19, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558867767, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558867767, 0);
INSERT INTO `tb_works_copyright` VALUES (18, 5, 20, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558924419, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558924419, 0);
INSERT INTO `tb_works_copyright` VALUES (19, 5, 21, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937370, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937370, 0);
INSERT INTO `tb_works_copyright` VALUES (20, 5, 22, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937484, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937484, 0);
INSERT INTO `tb_works_copyright` VALUES (21, 5, 23, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937487, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937487, 0);
INSERT INTO `tb_works_copyright` VALUES (22, 5, 24, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937487, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937487, 0);
INSERT INTO `tb_works_copyright` VALUES (23, 5, 25, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937488, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937488, 0);
INSERT INTO `tb_works_copyright` VALUES (24, 5, 26, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937489, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937489, 0);
INSERT INTO `tb_works_copyright` VALUES (25, 5, 30, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937790, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937790, 0);
INSERT INTO `tb_works_copyright` VALUES (26, 5, 31, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937791, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937791, 0);
INSERT INTO `tb_works_copyright` VALUES (27, 5, 37, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937955, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937955, 0);
INSERT INTO `tb_works_copyright` VALUES (28, 5, 38, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937957, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937957, 0);
INSERT INTO `tb_works_copyright` VALUES (29, 5, 39, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937984, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937984, 0);
INSERT INTO `tb_works_copyright` VALUES (30, 5, 40, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937985, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937985, 0);
INSERT INTO `tb_works_copyright` VALUES (31, 5, 41, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558937986, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558937986, 0);
INSERT INTO `tb_works_copyright` VALUES (32, 5, 42, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558938054, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558938054, 0);
INSERT INTO `tb_works_copyright` VALUES (33, 27, 43, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558938665, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558938665, 0);
INSERT INTO `tb_works_copyright` VALUES (34, 5, 44, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1558938888, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1558938888, 0);
INSERT INTO `tb_works_copyright` VALUES (35, 5, 45, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1559022893, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1559022893, 0);
INSERT INTO `tb_works_copyright` VALUES (36, 5, 46, '晨曦', '著作权存证', 46, 17, '2359c3786c79dd4ff3fbbe085630214226bcbf79305c53223382dee0aafa35d8', '', 0, 1559023070, 1559023070, 1559023070, 'b76535a0ae7a86813d1', '17839906235', '029b99c9e9d4d90c72e', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":1,\"Sizes\":50,\"Hmac\":\"\",\"StorageLocationURL\":\"\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"1276a09417e2f8ed73c663f45d74445972589c284d73196bf081a2916237b4ef\",\"IssuerSignature\":\"cd9e352caf1be10a2a479367fcc0100c88f750efb9854cc021c30158f0bdfc760e586f37e2b9d27c4275b5d5a866ff0254bf4933e552fa388cffb3d2865a05f9\",\"applicantSignature\":\"73810c892f5da5a67b755c67afc301f2156fb770d59e14e82917410060609a194605c6a9319dc0e899e5473b332f65f493e26132ceeae19502afce0a6bd75e9b\",\"BlockID\":\"\",\"TxID\":\"018880260eae06a12ec9ea51861719be3fc543731c8d16c362f720f4b6f749b4\"}\n', '1276a09417e2f8ed73c663f45d74445972589c284d73196bf081a2916237b4ef', 'cd9e352caf1be10a2a479367fcc0100c88f750efb9854cc021c30158f0bdfc760e586f37e2b9d27c4275b5d5a866ff0254bf4933e552fa388cffb3d2865a05f9', '73810c892f5da5a67b755c67afc301f2156fb770d59e14e82917410060609a194605c6a9319dc0e899e5473b332f65f493e26132ceeae19502afce0a6bd75e9b', '', '018880260eae06a12ec9ea51861719be3fc543731c8d16c362f720f4b6f749b4', 1559023070, 1559273334);
INSERT INTO `tb_works_copyright` VALUES (41, 27, 51, '晨曦', '著作权存证', 51, 17, 'dee0af9ad668798e9832a9e2478fa321d0824cb423d3e3c7707b14d2307a10d9', '', 1, 0, 0, 1559182073, 'b76535a0ae7a86813d1', '17839906235', '029b99c9e9d4d90c72e', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":1,\"Sizes\":50,\"Hmac\":\"\",\"StorageLocationURL\":\"\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"c5b2c27bedfb020316e8fdccb343bd5b51127d82928e367221ea3d5fe40d9cef\",\"IssuerSignature\":\"355034d6e09fa4f80fe65e3b179e7a32ba0eb888b3b1087a6b517cb90620a333583dd664101fae11d976bf4e351fe6ab9822628a97edc61d64228fccfb9627d1\",\"applicantSignature\":\"09013a81af501dbc5983219ef10d9703b39e5cd429505cd6274bab6e986ef7377d7e6fccbe05011817be62a9aacbde48800878f1b06a1bc31e45e99f94259a4a\",\"BlockID\":\"\",\"TxID\":\"d10eb5fabd9f7e04ed7a84082a44fa683271956b17b1b58f61164bfa0dcd1438\"}\n', 'c5b2c27bedfb020316e8fdccb343bd5b51127d82928e367221ea3d5fe40d9cef', '355034d6e09fa4f80fe65e3b179e7a32ba0eb888b3b1087a6b517cb90620a333583dd664101fae11d976bf4e351fe6ab9822628a97edc61d64228fccfb9627d1', '09013a81af501dbc5983219ef10d9703b39e5cd429505cd6274bab6e986ef7377d7e6fccbe05011817be62a9aacbde48800878f1b06a1bc31e45e99f94259a4a', '', 'd10eb5fabd9f7e04ed7a84082a44fa683271956b17b1b58f61164bfa0dcd1438', 1559182073, 1559206984);
INSERT INTO `tb_works_copyright` VALUES (42, 27, 52, '晨曦', '', 0, 17, '', '', 1, 0, 0, 1559182570, '0', '0', '0', '', '', '', 1, '', '', '', '', '', '', 1559182570, 0);
INSERT INTO `tb_works_copyright` VALUES (44, 5, 54, '晨曦1全文', '著作权存证', 54, 17, '', '', 1, 0, 1559544774, 1559544774, 'b76535a0ae7a86813d1', '17839906235', '029b99c9e9d4d90c72e', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":1,\"Sizes\":24,\"Hmac\":\"a3aa4f6d660325c35dedcf488f75e25133c1baf106a77f6d3b8c19fcfd93f6c4\",\"StorageLocationURL\":\"61.165.175.25:8080/static/upload/images/20190603/y9DVniny.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"4311e97c6f82495af9465f21ed206f6db5e7634ebff051389c9f1a1a88d54117\",\"IssuerSignature\":\"d644778bbfe93b8ea67aeba0f0e91b9a2c7b4d2aeb4e057d8c03102083c88daa053b7e93d03ec9dee1a60671cd55ac29d7164232b72feae9814e3a94eea01e17\",\"applicantSignature\":\"47481c8aed90164d0299b7b06be4a0a9f5a8b45a02847889e12835a4096439574483000e17f96acfcafd568a0df09b276d98fb4e5ddacc23369c7248a44e8e5b\",\"BlockID\":\"\",\"TxID\":\"a23c2d0e777aef9fd8fa9bc6aecd1ce05abe0c0fe0afa027828a6d09b34d86ce\"}\n', '4311e97c6f82495af9465f21ed206f6db5e7634ebff051389c9f1a1a88d54117', 'd644778bbfe93b8ea67aeba0f0e91b9a2c7b4d2aeb4e057d8c03102083c88daa053b7e93d03ec9dee1a60671cd55ac29d7164232b72feae9814e3a94eea01e17', '47481c8aed90164d0299b7b06be4a0a9f5a8b45a02847889e12835a4096439574483000e17f96acfcafd568a0df09b276d98fb4e5ddacc23369c7248a44e8e5b', '', 'a23c2d0e777aef9fd8fa9bc6aecd1ce05abe0c0fe0afa027828a6d09b34d86ce', 1559544774, 1559807108);
INSERT INTO `tb_works_copyright` VALUES (45, 5, 55, '晨曦', '著作权存证', 55, 17, '', '', 1, 1562220506, 1562220506, 1562220506, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":1,\"Sizes\":50,\"Hmac\":\"\",\"StorageLocationURL\":\"\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"d045e59c5eb808c20b7bd9e8236926583d82d60762dfc32ff413b05f439a1def\",\"IssuerSignature\":\"2e1aa1e47a559e3d371cd36cc626c25064697817aa8e207629ef21c13a79992b2dea4b302e0e60f5d2738ef92e688ce209c016b9e4eba540d6d080e39753ad8e\",\"applicantSignature\":\"2d2541579d6bee2326b9263999c34d19be0c54b87b0da20d693b6c91ad328175247d927bbd85c12593f2fab105b36a57ba66a87ac46e1f64d134a6d7ceab89d4\",\"BlockID\":\"\",\"TxID\":\"38bd4bf7d9d344c80d56265cb0fa57805fac491542b2980f6ce33e3f04fda48f\"}\n', 'd045e59c5eb808c20b7bd9e8236926583d82d60762dfc32ff413b05f439a1def', '2e1aa1e47a559e3d371cd36cc626c25064697817aa8e207629ef21c13a79992b2dea4b302e0e60f5d2738ef92e688ce209c016b9e4eba540d6d080e39753ad8e', '2d2541579d6bee2326b9263999c34d19be0c54b87b0da20d693b6c91ad328175247d927bbd85c12593f2fab105b36a57ba66a87ac46e1f64d134a6d7ceab89d4', '', '38bd4bf7d9d344c80d56265cb0fa57805fac491542b2980f6ce33e3f04fda48f', 1562220506, 1562316159);
INSERT INTO `tb_works_copyright` VALUES (48, 27, 60, '晨曦12', '著作权存证', 60, 43, '', '', 0, 1562309743, 1562309743, 1562309743, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":426,\"Hmac\":\"1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791\",\"StorageLocationURL\":\"180.175.237.210:7001/static/upload/images/20190705/QkdJl8fb.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"7dea770ff59d72f9957bd1918c0e3f0ce538b46722911479c5e67d92dcce150f\",\"IssuerSignature\":\"51a5f08d34244ce229ebb34aa7f0f151cd535e37037df2f088ba937045027b8815533f6cc2c26d9484c77f01b0b67d8eb57053720ce691fd0b6a5a50a1cba0a6\",\"applicantSignature\":\"493e78dc0c935e3989e86c31897514ba7bc45cca3d340fe406b401991d00afce2132f8d282aad967fefceeec2ff77a86300bc631cfe9b25f527840f863861660\",\"BlockID\":\"\",\"TxID\":\"a2f55bafe0402837ccdce855b7b31531d4660b18c5440bb973cfb2d73adfa49f\"}\n', '7dea770ff59d72f9957bd1918c0e3f0ce538b46722911479c5e67d92dcce150f', '51a5f08d34244ce229ebb34aa7f0f151cd535e37037df2f088ba937045027b8815533f6cc2c26d9484c77f01b0b67d8eb57053720ce691fd0b6a5a50a1cba0a6', '493e78dc0c935e3989e86c31897514ba7bc45cca3d340fe406b401991d00afce2132f8d282aad967fefceeec2ff77a86300bc631cfe9b25f527840f863861660', '', 'a2f55bafe0402837ccdce855b7b31531d4660b18c5440bb973cfb2d73adfa49f', 1562309743, 1562316163);
INSERT INTO `tb_works_copyright` VALUES (51, 27, 66, '晨曦', '著作权存证', 66, 43, '', '', 0, 1562315996, 1562315996, 1562315996, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":426,\"Hmac\":\"1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791\",\"StorageLocationURL\":\"180.175.237.210:7001/static/upload/images/20190705/Zvza19lq.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"e6013822ca924169cb745c1c1699a6d1921c2b927c959b83c9395c8acf64dd5f\",\"IssuerSignature\":\"20087ccacbec0d67edd9ada9a773a914315a6c7dbc6db48b97a90fdf14a8f64418e4472790d4a033870e473a2d954296b66d7e17c907d332510516a737a25d3d\",\"applicantSignature\":\"984c16d0fd3ea90b8847c738358182c1e4283ccb719331aaf6065db6d2d41d7c775f654ffa1d5405cc66c60e30e1593e3c8af382ea3b72f2d797bb69328f34f0\",\"BlockID\":\"\",\"TxID\":\"c2e51a6ac9f9ae95a5ce70e70f20d0c11d02f77e145279896f6de1f4d0116768\"}\n', 'e6013822ca924169cb745c1c1699a6d1921c2b927c959b83c9395c8acf64dd5f', '20087ccacbec0d67edd9ada9a773a914315a6c7dbc6db48b97a90fdf14a8f64418e4472790d4a033870e473a2d954296b66d7e17c907d332510516a737a25d3d', '984c16d0fd3ea90b8847c738358182c1e4283ccb719331aaf6065db6d2d41d7c775f654ffa1d5405cc66c60e30e1593e3c8af382ea3b72f2d797bb69328f34f0', '', 'c2e51a6ac9f9ae95a5ce70e70f20d0c11d02f77e145279896f6de1f4d0116768', 1562315996, 1562316303);
INSERT INTO `tb_works_copyright` VALUES (52, 27, 67, '晨曦', '', 0, 43, '', '', 0, 1562322172, 1562322172, 1562322172, '', '', '', '', '', '', 1, '', '', '', '', '', '', 1562322172, 0);
INSERT INTO `tb_works_copyright` VALUES (53, 27, 68, '111晨曦世界', '著作权存证', 68, 43, '', '', 0, 1562570969, 1562570969, 1562570969, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":14,\"Hmac\":\"c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/GRoJTlSx.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"cd1ac0b2234d55ae23608a308417156f168830daf480a296fe99751ad575346b\",\"IssuerSignature\":\"0f4657bac08acf36109dde27c23cff0581e0678374325fa340783644dd15dbbf105bcad78ca1fdc929c45bc21dd4a219809afb9541b03b70a6b0173065ca1a49\",\"applicantSignature\":\"40584d7e829e2ec48ddc88fa888f1703dd2dab3535fa74cf785eda2904cd1bc30b419535446055d2bda65ee3a512a48fc0dfe5a8107065ceaa4db3c6f25afa4e\",\"BlockID\":\"\",\"TxID\":\"fde2cff95e871aea49a536c7ef2dda8d048a25e7483841757eae699e55440d2f\"}\n', 'cd1ac0b2234d55ae23608a308417156f168830daf480a296fe99751ad575346b', '0f4657bac08acf36109dde27c23cff0581e0678374325fa340783644dd15dbbf105bcad78ca1fdc929c45bc21dd4a219809afb9541b03b70a6b0173065ca1a49', '40584d7e829e2ec48ddc88fa888f1703dd2dab3535fa74cf785eda2904cd1bc30b419535446055d2bda65ee3a512a48fc0dfe5a8107065ceaa4db3c6f25afa4e', '', 'fde2cff95e871aea49a536c7ef2dda8d048a25e7483841757eae699e55440d2f', 1562570969, 1562571708);
INSERT INTO `tb_works_copyright` VALUES (54, 27, 69, '测试111', '著作权存证', 69, 43, '', '', 0, 1562572461, 1562572461, 1562572461, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":28,\"Hmac\":\"e0eb2d4f3f46d97e1dbd6d3973cc6b98743f22275708751f79b287f3a298ce14\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/nquYzJ4x.jpeg\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"1410ce47684e8b11503bcc7246517b50e718ea2fd9f171b3db2416da518b3e9b\",\"IssuerSignature\":\"434cc43c4650927a7872ececad63dceda8da91509d4507c7a6dbe27eb4f042036f20074b4f853eb2db428e907293fe9d5e51eb0c228f30623da96f641ca00b8c\",\"applicantSignature\":\"116806e80c4346b9e415f3daec8fe0f41bdcdc3e131455bbd8bdf2cd31959e5b2c8ec56b3fb107f2e1b2cb98294f6f20feaf9528893f44a44b20947fa4467a3a\",\"BlockID\":\"\",\"TxID\":\"64301b4c656a763d85e94c2b43e0239e21dc270f17525d4772884b76adc8ae4f\"}\n', '1410ce47684e8b11503bcc7246517b50e718ea2fd9f171b3db2416da518b3e9b', '434cc43c4650927a7872ececad63dceda8da91509d4507c7a6dbe27eb4f042036f20074b4f853eb2db428e907293fe9d5e51eb0c228f30623da96f641ca00b8c', '116806e80c4346b9e415f3daec8fe0f41bdcdc3e131455bbd8bdf2cd31959e5b2c8ec56b3fb107f2e1b2cb98294f6f20feaf9528893f44a44b20947fa4467a3a', '', '64301b4c656a763d85e94c2b43e0239e21dc270f17525d4772884b76adc8ae4f', 1562572461, 1562572528);
INSERT INTO `tb_works_copyright` VALUES (55, 27, 70, '测试23', '著作权存证', 70, 43, '', '', 0, 1562573634, 1562573634, 1562573634, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":14,\"Hmac\":\"c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/A3Hh3bmm.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"a0b1e5b032a193db3e64d08f01aaeb19e47a9d6f43c5888554374b58170eb9ae\",\"IssuerSignature\":\"6447e8d1f9390da11370d911fb5275478e8182371db121d8e03c2d1c2d08d06b0eff5fecc4934e80aa986d6f05c15363f64820432445f7297232136145feaf44\",\"applicantSignature\":\"d933ff92016cf01b055317b87dc45f9046a73b5386038095281bdd55404060501d6fff4f231efb835063c7d0873d7d8745b3e991898434926324f44fa8a351c0\",\"BlockID\":\"\",\"TxID\":\"ac1430df62764617af6fbb08f23a239629b05deb8380da53dee7cf635cacbb60\"}\n', 'a0b1e5b032a193db3e64d08f01aaeb19e47a9d6f43c5888554374b58170eb9ae', '6447e8d1f9390da11370d911fb5275478e8182371db121d8e03c2d1c2d08d06b0eff5fecc4934e80aa986d6f05c15363f64820432445f7297232136145feaf44', 'd933ff92016cf01b055317b87dc45f9046a73b5386038095281bdd55404060501d6fff4f231efb835063c7d0873d7d8745b3e991898434926324f44fa8a351c0', '', 'ac1430df62764617af6fbb08f23a239629b05deb8380da53dee7cf635cacbb60', 1562573634, 1562573655);
INSERT INTO `tb_works_copyright` VALUES (56, 27, 71, '测试23111', '著作权存证', 71, 43, '', '', 0, 1562574642, 1562574642, 1562574642, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":28,\"Hmac\":\"e0eb2d4f3f46d97e1dbd6d3973cc6b98743f22275708751f79b287f3a298ce14\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/uaH0EntV.jpeg\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"fdd6d7818acdf145391a176e7cc33014744600d66d0b9ed6630c918bc09d72c4\",\"IssuerSignature\":\"cc4f42dd42e9db5b7b6027f5bbf06c9ba13a7b3fbd114a8b078cc3dad6f970177d6216e9c6a2e56591da23d08f1288bc5b5709b6a6ee2396f824f658ecbb6b2c\",\"applicantSignature\":\"927ab7835c7c86b3912281ebdb1d44e87bb4a1c47560742a22881e4c0ddb408e1e2dc241fdaf1bc5f863d1c6ef28e8125d7cd58ac17ba2feeb819cc7d25d70b8\",\"BlockID\":\"\",\"TxID\":\"dd7f1fa3fccdc0c46efa36e7464e021d06c774c5b23921fce4cecff99b1531f0\"}\n', 'fdd6d7818acdf145391a176e7cc33014744600d66d0b9ed6630c918bc09d72c4', 'cc4f42dd42e9db5b7b6027f5bbf06c9ba13a7b3fbd114a8b078cc3dad6f970177d6216e9c6a2e56591da23d08f1288bc5b5709b6a6ee2396f824f658ecbb6b2c', '927ab7835c7c86b3912281ebdb1d44e87bb4a1c47560742a22881e4c0ddb408e1e2dc241fdaf1bc5f863d1c6ef28e8125d7cd58ac17ba2feeb819cc7d25d70b8', '', 'dd7f1fa3fccdc0c46efa36e7464e021d06c774c5b23921fce4cecff99b1531f0', 1562574642, 1562574687);
INSERT INTO `tb_works_copyright` VALUES (57, 27, 72, '测试23sasa', '著作权存证', 72, 43, '', '', 0, 1562574817, 1562574817, 1562574817, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":251,\"Hmac\":\"9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/8CCUCiTV.jpeg\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"3804034547d50ed8e2e8a6b7925854afcc7ce7e6178528d4363367f5e399da5c\",\"IssuerSignature\":\"0dde09db53b9bb20e7ed7a5c5f611bbe5c5ba8895428a83956134ee329bd1ecc70bbf7b264d164e38d8469d65cf3f10d7390d81ed7d070373952581643c2edbf\",\"applicantSignature\":\"abd3827c3ab281fc8a21d69d19397e645fa3196f669534aeca61d4144f379bea05eb3cadb54cc352a352881993419cde0cad2ed813c6896e83435b8cf9c89e37\",\"BlockID\":\"\",\"TxID\":\"9dbdecc8788dadd166e560fa034cf1b6b88c85d86e022896559f728cf648472e\"}\n', '3804034547d50ed8e2e8a6b7925854afcc7ce7e6178528d4363367f5e399da5c', '0dde09db53b9bb20e7ed7a5c5f611bbe5c5ba8895428a83956134ee329bd1ecc70bbf7b264d164e38d8469d65cf3f10d7390d81ed7d070373952581643c2edbf', 'abd3827c3ab281fc8a21d69d19397e645fa3196f669534aeca61d4144f379bea05eb3cadb54cc352a352881993419cde0cad2ed813c6896e83435b8cf9c89e37', '', '9dbdecc8788dadd166e560fa034cf1b6b88c85d86e022896559f728cf648472e', 1562574817, 1562574849);
INSERT INTO `tb_works_copyright` VALUES (58, 27, 73, '测试23sasa', '著作权存证', 73, 43, '', '', 0, 1562575180, 1562575180, 1562575180, 'c4acfb68af5708b0961', '', 'c3deecbd391eb770a93', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":251,\"Hmac\":\"9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/zBEscAOA.jpeg\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"a6e80872de2257cb5095032551994bfae81928ae9cd2a3e2335a079d09471fbc\",\"IssuerSignature\":\"e061d2a295df1ee69b8f2103655ffe37445d8bf77be6e60a4dfd7421e69888c8664a4145e5f0973579a014acccfcd3e96ffb54d24ae6f29e398c472ebda0cf81\",\"applicantSignature\":\"ced4749877496879c0320745ffa839850e372811e4bec2b5029c7ec2c399684b07b9c8db50a86523de7108c197294139e204e332004d22662b1e2aae9315e8a6\",\"BlockID\":\"\",\"TxID\":\"255ce2046bd22315dbb1e9bf223629b345f3457a3529a742e12338e39766392d\"}\n', 'a6e80872de2257cb5095032551994bfae81928ae9cd2a3e2335a079d09471fbc', 'e061d2a295df1ee69b8f2103655ffe37445d8bf77be6e60a4dfd7421e69888c8664a4145e5f0973579a014acccfcd3e96ffb54d24ae6f29e398c472ebda0cf81', 'ced4749877496879c0320745ffa839850e372811e4bec2b5029c7ec2c399684b07b9c8db50a86523de7108c197294139e204e332004d22662b1e2aae9315e8a6', '', '255ce2046bd22315dbb1e9bf223629b345f3457a3529a742e12338e39766392d', 1562575180, 1562575257);
INSERT INTO `tb_works_copyright` VALUES (59, 27, 74, '晨曦', '著作权存证', 74, 43, '', '', 0, 1562584012, 1562584012, 1562584012, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":251,\"Hmac\":\"9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/N973Nil6.jpeg\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"9597582107982e4d04816c7bd3eddfe198591e1d42cacb6acbfd9c59445b0f2b\",\"IssuerSignature\":\"fa7f82cc353a96e01f51c193b5e0ceddf35f064befb4304d009e7aa51f0b49946db978ea10d21ca9fb1c289b887b8aa130b1ba5ca36915611709c6551b174868\",\"applicantSignature\":\"b2b2a793d620552d7dc160bcd7237ad71a5bded568fbc3422891f7a99c76522a66fe3cb5eb78132c796460560b56e37fc6a6db49415a5ceecb935f6e88028651\",\"BlockID\":\"\",\"TxID\":\"3b5f23829a8d35a744d8c4bdc7e5737cc9641ed896090eaa7ac255e8dbff0cc8\"}\n', '9597582107982e4d04816c7bd3eddfe198591e1d42cacb6acbfd9c59445b0f2b', 'fa7f82cc353a96e01f51c193b5e0ceddf35f064befb4304d009e7aa51f0b49946db978ea10d21ca9fb1c289b887b8aa130b1ba5ca36915611709c6551b174868', 'b2b2a793d620552d7dc160bcd7237ad71a5bded568fbc3422891f7a99c76522a66fe3cb5eb78132c796460560b56e37fc6a6db49415a5ceecb935f6e88028651', '', '3b5f23829a8d35a744d8c4bdc7e5737cc9641ed896090eaa7ac255e8dbff0cc8', 1562584012, 1562584044);
INSERT INTO `tb_works_copyright` VALUES (60, 27, 75, '晨曦', '著作权存证', 75, 43, '', '', 0, 1562584780, 1562584780, 1562584780, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":908,\"Hmac\":\"98c1e108e8b197381be4f5ff7cb5a524338d5d87c966f820ff798c7c5e00db69\",\"StorageLocationURL\":\"58.39.188.106:7001/static/upload/images/20190708/oaHe9nLl.jpg\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"0003f87d69d5e6d2e721ffad01e04983034378808b10857319cc76c975c45d66\",\"IssuerSignature\":\"33e9ef0a6a9a2c17d7d1f834c84ff4a17fe08c5d8f856f3f241ccaf4a52f96335606b90b42defa034fed393942a4c4533e39190e28c86802e7b0154bf3771c9c\",\"applicantSignature\":\"219d6b965e8f6707e9676e88cf39c8b64e12328cff676870f3e994e4aa3a91466619173cb139696160d6f42d475ec440b2a175ecea7a6e4743b53d9f84dfc91f\",\"BlockID\":\"\",\"TxID\":\"db78118a0499fe35574f7f2295cc86db0a6dafc8569caae79dcd03affe345897\"}\n', '0003f87d69d5e6d2e721ffad01e04983034378808b10857319cc76c975c45d66', '33e9ef0a6a9a2c17d7d1f834c84ff4a17fe08c5d8f856f3f241ccaf4a52f96335606b90b42defa034fed393942a4c4533e39190e28c86802e7b0154bf3771c9c', '219d6b965e8f6707e9676e88cf39c8b64e12328cff676870f3e994e4aa3a91466619173cb139696160d6f42d475ec440b2a175ecea7a6e4743b53d9f84dfc91f', '', 'db78118a0499fe35574f7f2295cc86db0a6dafc8569caae79dcd03affe345897', 1562584780, 1562584801);
INSERT INTO `tb_works_copyright` VALUES (61, 27, 76, '晨曦', '著作权存证', 76, 43, '', '', 0, 1562728886, 1562728886, 1562728886, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"叶子\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":426,\"Hmac\":\"1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791\",\"StorageLocationURL\":\"61.165.156.18:7001/static/upload/images/20190710/eUIB5eKS.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"4cc81973c80b6586e0543c76b4ecf1c72269e619d8d58d152c4885086f23cb40\",\"IssuerSignature\":\"967ade9a00873da65bdddc8cf98fc808f99f0ff145224dd47d4be21fc0221b0e4e4a3bd878964587fb96b0eda203b89561acfa0b258233b3cd25df12f607f4e6\",\"applicantSignature\":\"17146610a174a200247a0235c526682f430d40f55a5d35b57c334e468514f6ec47bbf530f8591dd818cbf1e41bceaa2ecd74e85971aee67f8303fd622f3e7a7e\",\"BlockID\":\"\",\"TxID\":\"a59202e306b306b4317a9713b5f818b523fc99af32f481d36ac034c94ca90a7d\"}\n', '4cc81973c80b6586e0543c76b4ecf1c72269e619d8d58d152c4885086f23cb40', '967ade9a00873da65bdddc8cf98fc808f99f0ff145224dd47d4be21fc0221b0e4e4a3bd878964587fb96b0eda203b89561acfa0b258233b3cd25df12f607f4e6', '17146610a174a200247a0235c526682f430d40f55a5d35b57c334e468514f6ec47bbf530f8591dd818cbf1e41bceaa2ecd74e85971aee67f8303fd622f3e7a7e', '', 'a59202e306b306b4317a9713b5f818b523fc99af32f481d36ac034c94ca90a7d', 1562728886, 1562728914);
INSERT INTO `tb_works_copyright` VALUES (62, 27, 77, '视频监测', '著作权存证', 77, 17, '', '', 0, 1562741378, 1562741378, 1562741378, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"晨曦\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":1,\"Sizes\":22291,\"Hmac\":\"0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d\",\"StorageLocationURL\":\"61.165.156.18:7001/static/upload/videos/20190710/AGC1jbso.mov\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"eb20dd264aa78aa7f0121119139f325cd0b951954416a0b273f13a4cf1fb8f2d\",\"IssuerSignature\":\"eb0b8c3ba897b530ac15330909ba3bbece3e49a94814055fa3487ba98c587ecb2b81f7db36005373b248d546424bd7f84b61af336c5b7fde95bd9e9aff99a1e8\",\"applicantSignature\":\"18ca2a90e270cb097862dc531d7ce59cd6a655c33274480306342ea6cf21bebe5eed355bef7b653e4d21f1a364bb8c463d7ab506db7f303bb3770b0f0c5e0b33\",\"BlockID\":\"\",\"TxID\":\"a5bbea72181ed9a470be8052d78fb8002f82ad8a45761fa993431b93b91fec37\"}\n', 'eb20dd264aa78aa7f0121119139f325cd0b951954416a0b273f13a4cf1fb8f2d', 'eb0b8c3ba897b530ac15330909ba3bbece3e49a94814055fa3487ba98c587ecb2b81f7db36005373b248d546424bd7f84b61af336c5b7fde95bd9e9aff99a1e8', '18ca2a90e270cb097862dc531d7ce59cd6a655c33274480306342ea6cf21bebe5eed355bef7b653e4d21f1a364bb8c463d7ab506db7f303bb3770b0f0c5e0b33', '', 'a5bbea72181ed9a470be8052d78fb8002f82ad8a45761fa993431b93b91fec37', 1562741378, 1562741394);
INSERT INTO `tb_works_copyright` VALUES (63, 27, 78, '测试图片', '著作权存证', 78, 43, '', '', 0, 1563259497, 1563259497, 1563259497, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"叶子\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":14,\"Hmac\":\"\",\"StorageLocationURL\":\"114.91.127.84:7001/static/upload/verified/personal/20190716/WDUqEMVq.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"777c1f06ae518c03a049af0e0c61f5d47b5718fd994aee1fae45a9923069a6b0\",\"IssuerSignature\":\"559846277d38c6f7670ff673d2a3cf51ea9f8ae18b48e9c0db0b81b50b08bc4429564153e9b16c5f7f93e1da4ee331261aa7fbce5a43e29f01833aa2eff01188\",\"applicantSignature\":\"89142536d5c5e5c5952059ddf6e4e2f62987d0a10557bab85b5e5d72c77e05cb30ee44a34931b30db41eb7433289a0e3b16622b0644307cabe58dcf52bba11c3\",\"BlockID\":\"\",\"TxID\":\"b18e9df6391a22731d05ed6895d168b4b6f331e21e15abf803c318cfff9b7410\"}\n', '777c1f06ae518c03a049af0e0c61f5d47b5718fd994aee1fae45a9923069a6b0', '559846277d38c6f7670ff673d2a3cf51ea9f8ae18b48e9c0db0b81b50b08bc4429564153e9b16c5f7f93e1da4ee331261aa7fbce5a43e29f01833aa2eff01188', '89142536d5c5e5c5952059ddf6e4e2f62987d0a10557bab85b5e5d72c77e05cb30ee44a34931b30db41eb7433289a0e3b16622b0644307cabe58dcf52bba11c3', '', 'b18e9df6391a22731d05ed6895d168b4b6f331e21e15abf803c318cfff9b7410', 1563259497, 1563259524);
INSERT INTO `tb_works_copyright` VALUES (64, 27, 79, '晨曦', '著作权存证', 79, 43, '', '', 0, 1563278965, 1563278965, 1563278965, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"叶子\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":94,\"Hmac\":\"19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330\",\"StorageLocationURL\":\"114.91.127.84:7001/static/upload/images/20190716/z2yzLrsE.png\"}', 1, '{\"Result\":1,\"FailureDescription\":\"\",\"certificationID\":\"786c4324f17e797a125326e11c816e29939ee009a8e02816da35abb6e01bf834\",\"IssuerSignature\":\"615487c50146533ab6c1df6e0ad9d1cfeea0fd8f5d0edc5e768a2d0dcbf20d183f6891b2b4deac248d9bd3401cf3b1ba32abcaded27d0960f7d33d154639074c\",\"applicantSignature\":\"27a52ce7edb098f1dade9847fe8db1c792aee48c5690974103f7bb9f2053b0ba56dadcedaed140436c37b3eb852c02f20693c727188efaa442af90b4d2eab964\",\"BlockID\":\"\",\"TxID\":\"0d182fe8bd2773e99326f1d13586a79bb1e474af50c9cef47fd486d1de52aec1\"}\n', '786c4324f17e797a125326e11c816e29939ee009a8e02816da35abb6e01bf834', '615487c50146533ab6c1df6e0ad9d1cfeea0fd8f5d0edc5e768a2d0dcbf20d183f6891b2b4deac248d9bd3401cf3b1ba32abcaded27d0960f7d33d154639074c', '27a52ce7edb098f1dade9847fe8db1c792aee48c5690974103f7bb9f2053b0ba56dadcedaed140436c37b3eb852c02f20693c727188efaa442af90b4d2eab964', '', '0d182fe8bd2773e99326f1d13586a79bb1e474af50c9cef47fd486d1de52aec1', 1563278965, 1563278970);
INSERT INTO `tb_works_copyright` VALUES (65, 27, 80, '中国文化所讲的人情是指人与人之间的性情。人情这两个字，现在解释来看，包括了社会学，政治学，心理学，行为学等等学问都在内，也可以理解为人与人之间融洽相处的感情。世故就是透彻了解事物，懂得过去，现在，未来。故是事情，世故就是世界上这些事情，要懂得人，要懂得事，就叫做人情世故', '著作权存证', 80, 43, '', '', 0, 1563352530, 1563352530, 1563352530, 'c4acfb68af5708b0961', '', '575d6042f8a6cfb9fea', '文飞墨舞', '{\"RightOwnerName\":\"在《菜根谭》一书中有话说:人情反复，世路崎岖。行不去处，须知退一步之法；行得去处，务加三分之功，大致的意思是：人间世情反复无常，人生之路崎岖不平，在人生道路上有走不通的地方，要知道退让一步的道理，在走的过去的地方，也一定 要给予人间三分的便利，这样才能逢凶化吉，一帆风顺\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":4,\"Sizes\":94,\"Hmac\":\"19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330\",\"StorageLocationURL\":\"114.91.116.107:7001/static/upload/images/20190716/nnigMroW.PNG\"}', 2, '{\"Result\":0,\"FailureDescription\":\"elem item invalid, type: 3\",\"certificationID\":\"\",\"IssuerSignature\":\"\",\"applicantSignature\":\"\",\"BlockID\":\"\",\"TxID\":\"\"}\n', '', '', '', '', '', 1563352530, 1563352588);
INSERT INTO `tb_works_copyright` VALUES (66, 38, 81, '晨曦', '著作权存证', 81, 43, '', '', 0, 1564127392, 1564127392, 1564127392, '89df2384fa8b32afab8', '', '5929a78492067d37039', '文飞墨舞', '{\"RightOwnerID\":\"\",\"RightOwnerName\":\"叶子\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"FileType\":4,\"Sizes\":50,\"FileHash\":\"\",\"StorageLocationURL\":\"\"}', 1, '{\"ErrCode\":0,\"Msg\":\"success\",\"Result\":{\"CertificationID\":\"7ef30b0859d0e969b1e6e7a02cceac76326e38a906e0d03a088488253a70b0e1\",\"IssuerSignature\":\"8bb7a5304304c8464db971c7d571297ed94d3b5e104c9bfcd2288fa49966a121126027924d338bb24dcc385d1fa52fd9cdd76edfcac0f236cb04d95270f41644\",\"ApplicantSignature\":\"0fc081159e498aae5396f23cd3f4a0d1e9d2fe8c72f23b5b82d89596e96b310236d3e8c4b60db3284d7083cb749568694f3b3ea38558ddd70bc416e11a6d8d7a\",\"BlockID\":\"\",\"TxID\":\"\"}}\n', '7ef30b0859d0e969b1e6e7a02cceac76326e38a906e0d03a088488253a70b0e1', '8bb7a5304304c8464db971c7d571297ed94d3b5e104c9bfcd2288fa49966a121126027924d338bb24dcc385d1fa52fd9cdd76edfcac0f236cb04d95270f41644', '0fc081159e498aae5396f23cd3f4a0d1e9d2fe8c72f23b5b82d89596e96b310236d3e8c4b60db3284d7083cb749568694f3b3ea38558ddd70bc416e11a6d8d7a', '', '', 1564127392, 1564128711);
INSERT INTO `tb_works_copyright` VALUES (67, 38, 82, '晨曦', '著作权存证', 82, 43, '', '', 0, 1564128839, 1564128839, 1564128839, '89df2384fa8b32afab8', '', '5929a78492067d37039', '文飞墨舞', '{\"RightOwnerID\":\"\",\"RightOwnerName\":\"叶子\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"FileType\":4,\"Sizes\":426,\"FileHash\":\"1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791\",\"StorageLocationURL\":\"218.83.30.2:7001/static/upload/images/20190726/NSG8JBrR.png\"}', 1, '{\"ErrCode\":0,\"Msg\":\"success\",\"Result\":{\"CertificationID\":\"34cec9b8a87bb8aec571cc49639232f50fc71e3bdce2b21b045e412380c4bf1c\",\"IssuerSignature\":\"86fd7eca2291749d2434ed3a198c42a9bbd4d36cca6761fb4a433c0e780ad4b129d01e059b240a447e998a3e406a48b81be8edbee3c62e88be54b4ba34abe989\",\"ApplicantSignature\":\"ed282ac6f1ddabec2399536b55303d68d40a65b4174f4cfe9e8e2929fdb964582e898996f3441675fc097c3b08250ada73d66cce11500263e9b6a03fca2e035b\",\"BlockID\":\"\",\"TxID\":\"\"}}\n', '34cec9b8a87bb8aec571cc49639232f50fc71e3bdce2b21b045e412380c4bf1c', '86fd7eca2291749d2434ed3a198c42a9bbd4d36cca6761fb4a433c0e780ad4b129d01e059b240a447e998a3e406a48b81be8edbee3c62e88be54b4ba34abe989', 'ed282ac6f1ddabec2399536b55303d68d40a65b4174f4cfe9e8e2929fdb964582e898996f3441675fc097c3b08250ada73d66cce11500263e9b6a03fca2e035b', '', '', 1564128839, 1564128898);
INSERT INTO `tb_works_copyright` VALUES (68, 40, 83, '晨曦', '著作权存证', 83, 43, '', '', 0, 1564132307, 1564132307, 1564132307, 'fe9bcf73785e3978996', '', 'd756f3de73026881ff2', '文飞墨舞', '{\"RightOwnerID\":\"\",\"RightOwnerName\":\"叶子\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"FileType\":4,\"Sizes\":14,\"FileHash\":\"c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da\",\"StorageLocationURL\":\"218.83.30.2:7001/static/upload/images/20190726/RQdbCXCL.png\"}', 1, '{\"ErrCode\":0,\"Msg\":\"success\",\"Result\":{\"CertificationID\":\"6f80359bbf683dfa92a8c4bc7a54da536a2fa869135c5c4a83f566b0505a9697\",\"IssuerSignature\":\"ea8281be2f6376337e95cb4c837b214a24affab3db7d7766ce6b63debc847d6e25c93123e28e3b07769e13006e03551ec0313fb58e3ea4a18c4cd9d78478f8f8\",\"ApplicantSignature\":\"adb85d5d4ea73c6bbf815696005a7890b25241970d5422f2803d66062c079ff0355b8996e36654c437dedefab33a30996ba3b690233e1bce9288c01587e00f6b\",\"BlockID\":\"\",\"TxID\":\"\"}}\n', '6f80359bbf683dfa92a8c4bc7a54da536a2fa869135c5c4a83f566b0505a9697', 'ea8281be2f6376337e95cb4c837b214a24affab3db7d7766ce6b63debc847d6e25c93123e28e3b07769e13006e03551ec0313fb58e3ea4a18c4cd9d78478f8f8', 'adb85d5d4ea73c6bbf815696005a7890b25241970d5422f2803d66062c079ff0355b8996e36654c437dedefab33a30996ba3b690233e1bce9288c01587e00f6b', '', '', 1564132307, 1564132343);
INSERT INTO `tb_works_copyright` VALUES (69, 40, 84, '晨曦', '著作权存证', 84, 43, '', '', 0, 1564134245, 1564134245, 1564134245, 'fe9bcf73785e3978996', '', 'd756f3de73026881ff2', '文飞墨舞', '{\"RightOwnerID\":\"\",\"RightOwnerName\":\"叶子\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"FileType\":4,\"Sizes\":14,\"FileHash\":\"c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da\",\"StorageLocationURL\":\"218.83.30.2:7001/static/upload/images/20190726/EqtxP9tP.png\"}', 1, '{\"ErrCode\":0,\"Msg\":\"success\",\"Result\":{\"CertificationID\":\"51848e79e2149f1cfffabc12f085aca31690e6933b25f6940fe4b18772012e5d\",\"IssuerSignature\":\"aeb84198d891c052532af170dc010be25394a32f750ee78ded978860627655d8092750c10c8c6ed241c2ab2c84f0a35b6bed4aaac73e23e24cfe8fb1b1d0f567\",\"ApplicantSignature\":\"eac672b007473fc36498e00aa6a5fb25ae25c47ae9339b62039b9774acba199531d50da9f716b1378121c4b8eca52f2d0a18c37eadfb6e5accc74e2b5099655d\",\"BlockID\":\"\",\"TxID\":\"\"}}\n', '51848e79e2149f1cfffabc12f085aca31690e6933b25f6940fe4b18772012e5d', 'aeb84198d891c052532af170dc010be25394a32f750ee78ded978860627655d8092750c10c8c6ed241c2ab2c84f0a35b6bed4aaac73e23e24cfe8fb1b1d0f567', 'eac672b007473fc36498e00aa6a5fb25ae25c47ae9339b62039b9774acba199531d50da9f716b1378121c4b8eca52f2d0a18c37eadfb6e5accc74e2b5099655d', '', '', 1564134245, 1564134254);
INSERT INTO `tb_works_copyright` VALUES (70, 40, 85, '晨曦', '著作权存证', 85, 43, '', '', 0, 1564563107, 1564563107, 1564563107, 'fe9bcf73785e3978996', '', 'df80aa5dcd87eb1dd4d', '文飞墨舞', '{\"RightOwnerID\":\"\",\"RightOwnerName\":\"叶子\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"FileType\":4,\"Sizes\":14,\"FileHash\":\"c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da\",\"StorageLocationURL\":\"114.91.125.162:7004/static/upload/images/20190731/7DDrtVOe.png\"}', 1, '{\"ErrCode\":0,\"Msg\":\"success\",\"Result\":{\"CertificationID\":\"659f3a9476a1a2b501c230c49327a26fc93ee2fb997092f35fb27c029a2b9a34\",\"IssuerSignature\":\"a47832b197195beea3f880847d36df2c75a428c45327b227f64ded21dbe754ec526b8b02decc56ecc998f190e5dfe7afa74775f9e544df81900786bbc98fc165\",\"ApplicantSignature\":\"cb15f3eec38c416621013ccbcd2683fc0758c71772114339c813e67c1be718ae05a00c5242f63d815266d0edc4caf834bb7ae3e811d79db3baca4c3f549826a4\",\"BlockID\":\"\",\"TxID\":\"92c40bc56e43d06bafd5031e477d5189bcfdf00c5acb84eeb798569615d4b0ca\"}}\n', '659f3a9476a1a2b501c230c49327a26fc93ee2fb997092f35fb27c029a2b9a34', 'a47832b197195beea3f880847d36df2c75a428c45327b227f64ded21dbe754ec526b8b02decc56ecc998f190e5dfe7afa74775f9e544df81900786bbc98fc165', 'cb15f3eec38c416621013ccbcd2683fc0758c71772114339c813e67c1be718ae05a00c5242f63d815266d0edc4caf834bb7ae3e811d79db3baca4c3f549826a4', '', '92c40bc56e43d06bafd5031e477d5189bcfdf00c5acb84eeb798569615d4b0ca', 1564563107, 1564563135);
INSERT INTO `tb_works_copyright` VALUES (71, 27, 86, '晨曦', '著作权存证', 86, 17, '', '', 0, 1566040827, 1566040827, 1566040827, 'c4acfb68af5708b0961', '', '1d684cd2ab0babc2b99', '文飞墨舞', '{\"ownerName\":\"叶子\",\"ownerId\":\"\",\"rightExpiration\":\"\",\"rightSourceType\":\"\"}', '{\"fileType\":1,\"sizes\":22265,\"fileHash\":\"9079d319326301aafdd593d345666eb44edb837b8180c92808881f6d5de65b70\",\"storageLocationURL\":\"101.93.10.113:7015/static/upload/videos/20190817/Ovi93vor.mov\"}', 2, '{\"success\":false,\"data\":null,\"msg\":\"system error Index 10 out of bounds for length 10\"}', '', '', '', '', '', 1566040827, 1566136732);
INSERT INTO `tb_works_copyright` VALUES (72, 27, 87, '晨曦', '著作权存证', 87, 17, '', '', 0, 1566111753, 1566111753, 1566111753, 'c4acfb68af5708b0961', '', '1d684cd2ab0babc2b99', '文飞墨舞', '{\"RightOwnerName\":\"叶子\",\"RightOwnerID\":\"\",\"RightExpiration\":\"\",\"RightSourceType\":\"\"}', '{\"Filetype\":1,\"Sizes\":22291,\"Hmac\":\"0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d\",\"StorageLocationURL\":\"101.93.10.113:7015/static/upload/videos/20190817/etKBiAMu.mov\"}', 2, '', '', '', '', '', '', 1566111753, 1566111891);
COMMIT;

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
-- Records of tb_works_files
-- ----------------------------
BEGIN;
INSERT INTO `tb_works_files` VALUES (1, 5, 52, 1, 1558511846, 'static/upload/20190522/oQLSilCr.mov', 1, 1559182570, '', '0', '');
INSERT INTO `tb_works_files` VALUES (2, 5, 50, 1, 1558511847, 'static/upload/20190522/rvXR6Feg.mov', 1, 1559024100, '', '0', '');
INSERT INTO `tb_works_files` VALUES (3, 5, 20, 1, 1558512929, 'static/upload/audios/20190522/YkEFHg9O.mov', 1, 1558924419, '', '0', '');
INSERT INTO `tb_works_files` VALUES (4, 1, 0, 3, 1558514074, 'static/upload/images/20190522/4GsexDgE.png', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (5, 1, 0, 3, 1558514106, 'static/upload/images/20190522/6GyrNmNy.png', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (6, 5, 50, 2, 1558514186, 'static/upload/audios/20190522/w4UmvVsF.mp3', 1, 1559024100, '', '0', '');
INSERT INTO `tb_works_files` VALUES (7, 5, 45, 4, 1558514258, 'static/upload/files/20190522/TdOt2vz9.doc', 1, 1559022893, '', '0', '');
INSERT INTO `tb_works_files` VALUES (8, 5, 44, 1, 1558514421, 'static/upload/videos/20190522/xvUNHrGK.mov', 1, 1558938888, '', '0', '');
INSERT INTO `tb_works_files` VALUES (9, 5, 45, 1, 1558514568, 'static/upload/videos/20190522/Z9OMZCIk.mov', 1, 1559022893, '', '0', '');
INSERT INTO `tb_works_files` VALUES (10, 5, 11, 1, 1558514881, 'static/upload/videos/20190522/wSftxAxD.mov', 1, 1558518788, '', '0', '');
INSERT INTO `tb_works_files` VALUES (11, 5, 9, 1, 1558514891, 'static/upload/videos/20190522/WX6K2emj.mov', 1, 1558518659, '', '0', '');
INSERT INTO `tb_works_files` VALUES (12, 1, 12, 1, 1558579010, 'static/upload/videos/20190523/MdqJCKtl.mov', 1, 1558579083, '', '0', '');
INSERT INTO `tb_works_files` VALUES (13, 1, 0, 3, 1558688721, 'static/upload/images/20190524/4yud7equ.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (14, 1, 0, 3, 1558690067, 'static/upload/images/20190524/hTEWheOE.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (15, 5, 46, 1, 1558694879, 'static/upload/videos/20190524/WO7FmstJ.mov', 1, 1559023070, '', '0', '');
INSERT INTO `tb_works_files` VALUES (16, 1, 0, 3, 1558696294, 'static/upload/images/20190524/truvr4bx.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (17, 1, 0, 3, 1558696533, 'static/upload/images/20190524/t69IZHKM.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (18, 1, 0, 3, 1558696564, 'static/upload/images/20190524/Y9qKaUyI.png', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (19, 1, 0, 3, 1558696640, 'static/upload/images/20190524/6mByDxIb.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (20, 5, 42, 3, 1558697271, 'static/upload/images/20190524/EqvdIOt3.png', 1, 1558938054, '', '0', '');
INSERT INTO `tb_works_files` VALUES (21, 5, 42, 3, 1558697284, 'static/upload/images/20190524/sPwQ8hx7.jpg', 1, 1558938054, '', '0', '');
INSERT INTO `tb_works_files` VALUES (22, 5, 43, 3, 1558697300, 'static/upload/images/20190524/GmoMAiD5.jpeg', 1, 1558938665, '', '0', '');
INSERT INTO `tb_works_files` VALUES (23, 1, 0, 3, 1558697398, 'static/upload/images/20190524/EddPGWtl.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (24, 1, 0, 3, 1558697458, 'static/upload/images/20190524/wluPfvUf.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (25, 1, 0, 3, 1558697493, 'static/upload/images/20190524/U2b1JU7g.jpeg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (26, 1, 0, 3, 1558697707, 'static/upload/images/20190524/EDOscvvc.jpeg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (27, 5, 51, 3, 1558750914, 'static/upload/images/20190525/eZw8Yks7.jpeg', 1, 1559182073, '', '0', '');
INSERT INTO `tb_works_files` VALUES (28, 10, 0, 3, 1558753151, 'static/upload/images/20190525/qCL5FjgV.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (29, 10, 0, 3, 1558754085, 'static/upload/images/20190525/BvVG2jjy.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (30, 10, 0, 3, 1558765325, 'static/upload/images/20190525/BuMDihIc.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (31, 10, 0, 3, 1558766205, 'static/upload/images/20190525/HmiJT6Mo.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (32, 10, 0, 3, 1558766283, 'static/upload/images/20190525/YVlBrWvd.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (33, 10, 0, 3, 1558767758, 'static/upload/images/20190525/7EDY1IOE.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (34, 10, 0, 3, 1558767862, 'static/upload/images/20190525/AwTT3evT.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (35, 10, 0, 3, 1558767945, 'static/upload/images/20190525/5RUx76Rz.jpg', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (36, 10, 0, 1, 1558768337, 'static/upload/videos/20190525/3hHPUQi0.mp4', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (37, 10, 0, 1, 1558768778, 'static/upload/videos/20190525/XnVZIwqo.mp4', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (38, 10, 0, 1, 1558768907, 'static/upload/videos/20190525/8j5RSPu0.mp4', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (39, 10, 0, 1, 1558768934, 'static/upload/videos/20190525/aVxv6QMi.mp4', 0, 0, '', '0', '');
INSERT INTO `tb_works_files` VALUES (40, 10, 12, 1, 1558769061, 'static/upload/videos/20190525/mmMIhgki.mp4', 1, 1558936097, '', '0', '');
INSERT INTO `tb_works_files` VALUES (41, 10, 12, 1, 1558769175, 'static/upload/videos/20190525/BxVPL91D.mp4', 1, 1558936097, '', '0', '');
INSERT INTO `tb_works_files` VALUES (42, 10, 12, 1, 1558769827, 'static/upload/videos/20190525/YwRIJIpU.mp4', 1, 1558936097, '', '0', '');
INSERT INTO `tb_works_files` VALUES (47, 5, 54, 3, 1559541937, 'static/upload/images/20190603/y9DVniny.png', 1, 1559544774, 'a3aa4f6d660325c35dedcf488f75e25133c1baf106a77f6d3b8c19fcfd93f6c4', '25194', '');
INSERT INTO `tb_works_files` VALUES (48, 5, 0, 4, 1559542090, 'static/upload/files/20190603/ZYmIv6xF.txt', 0, 0, '81a8a792dd5591985b14f6af22cb2eda9519ca355786d79a3de26f57ca743a2c', '0', '');
INSERT INTO `tb_works_files` VALUES (49, 5, 0, 1, 1559543074, 'static/upload/videos/20190603/6XLgU2TF.mov', 0, 0, '9079d319326301aafdd593d345666eb44edb837b8180c92808881f6d5de65b70', '0', '');
INSERT INTO `tb_works_files` VALUES (50, 5, 0, 2, 1559543117, 'static/upload/audios/20190603/mbcA2ZTp.mp3', 0, 0, '23771ec7830ded35e35b2e083c68676044ecc1989e0d28cb2cca8c49ec7880c4', '0', '');
INSERT INTO `tb_works_files` VALUES (51, 5, 0, 3, 1559791824, 'static/upload/images/20190606/YczXLHPN.jpg', 0, 0, '2b49606e7af22f9d17be7413a77a8d6efd34900b9433b5a3af019e4c9786d1c8', '24194', '');
INSERT INTO `tb_works_files` VALUES (52, 27, 0, 5, 1562055178, 'static/upload/verified/personal/20190702/yDxLKljn.jpeg', 0, 0, '', '138045', '');
INSERT INTO `tb_works_files` VALUES (53, 27, 0, 5, 1562055252, 'static/upload/verified/enterprise/license/20190702/B4QUeDXx.jpeg', 0, 0, '', '138045', '');
INSERT INTO `tb_works_files` VALUES (54, 27, 0, 5, 1562055258, 'static/upload/verified/enterprise/document/20190702/Yyw6YjTs.jpeg', 0, 0, '', '138045', '');
INSERT INTO `tb_works_files` VALUES (55, 27, 0, 5, 1562055262, 'static/upload/verified/enterprise/entrust/20190702/aH4k0bic.jpeg', 0, 0, '', '138045', '');
INSERT INTO `tb_works_files` VALUES (56, 27, 0, 5, 1562055265, 'static/upload/verified/other/20190702/CZrP5Z0N.jpeg', 0, 0, '', '138045', '');
INSERT INTO `tb_works_files` VALUES (57, 27, 0, 5, 1562055725, 'static/upload/verified/personal/20190702/cshoXRCu.pdf', 0, 0, '', '9650406', '');
INSERT INTO `tb_works_files` VALUES (58, 27, 0, 5, 1562055738, 'static/upload/verified/personal/20190702/D5Mqfs8J.jpeg', 0, 0, '', '257558', '');
INSERT INTO `tb_works_files` VALUES (59, 27, 0, 5, 1562208220, 'static/upload/verified/personal/20190704/nn3oo8CV.jpeg', 0, 0, '', '257558', '');
INSERT INTO `tb_works_files` VALUES (60, 27, 60, 3, 1562306722, 'static/upload/images/20190705/QkdJl8fb.png', 1, 1562309743, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (61, 27, 66, 3, 1562306726, 'static/upload/images/20190705/Zvza19lq.png', 1, 1562315996, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '83406d6b5def5586ec50fc8f111c3062b5554f7f4d5fa8374a32ca473b7d0463');
INSERT INTO `tb_works_files` VALUES (62, 27, 66, 3, 1562306727, 'static/upload/images/20190705/FeuGJsfX.png', 1, 1562315996, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '83406d6b5def5586ec50fc8f111c3062b5554f7f4d5fa8374a32ca473b7d0463');
INSERT INTO `tb_works_files` VALUES (63, 27, 67, 3, 1562306728, 'static/upload/images/20190705/HswtQBZ5.png', 1, 1562322172, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791');
INSERT INTO `tb_works_files` VALUES (64, 27, 71, 3, 1562552150, 'static/upload/images/20190708/uaH0EntV.jpeg', 1, 1562574642, 'e0eb2d4f3f46d97e1dbd6d3973cc6b98743f22275708751f79b287f3a298ce14', '29420', 'e0eb2d4f3f46d97e1dbd6d3973cc6b98743f22275708751f79b287f3a298ce14');
INSERT INTO `tb_works_files` VALUES (65, 27, 0, 1, 1562552162, 'static/upload/videos/20190708/Sax6qSga.mov', 0, 0, '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d', '22826143', '');
INSERT INTO `tb_works_files` VALUES (66, 27, 0, 4, 1562552177, 'static/upload/files/20190708/DXvPOkMy.txt', 0, 0, '2c3b1aa65e8b2fe025538b0e99b8303c7f28797e947b54f3104c8fc982d39a2b', '7537424', '');
INSERT INTO `tb_works_files` VALUES (67, 27, 0, 2, 1562552207, 'static/upload/audios/20190708/vUjAGEiu.mp3', 0, 0, '87eefb303fbe0116e023ef2cc04168e243fb2ef2092e6b16d3791f4ba9f5e5cf', '8666779', '');
INSERT INTO `tb_works_files` VALUES (68, 27, 0, 0, 1562552214, 'static/upload/other/20190708/R6GzmPec.mp3', 0, 0, '87eefb303fbe0116e023ef2cc04168e243fb2ef2092e6b16d3791f4ba9f5e5cf', '8666779', '');
INSERT INTO `tb_works_files` VALUES (69, 27, 70, 3, 1562554110, 'static/upload/images/20190708/A3Hh3bmm.png', 1, 1562573634, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da');
INSERT INTO `tb_works_files` VALUES (70, 27, 68, 3, 1562554127, 'static/upload/images/20190708/GRoJTlSx.png', 1, 1562570969, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da');
INSERT INTO `tb_works_files` VALUES (71, 27, 69, 3, 1562556030, 'static/upload/images/20190708/nquYzJ4x.jpeg', 1, 1562572461, 'e0eb2d4f3f46d97e1dbd6d3973cc6b98743f22275708751f79b287f3a298ce14', '29420', 'e0eb2d4f3f46d97e1dbd6d3973cc6b98743f22275708751f79b287f3a298ce14');
INSERT INTO `tb_works_files` VALUES (72, 27, 72, 3, 1562574758, 'static/upload/images/20190708/8CCUCiTV.jpeg', 1, 1562574817, '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb', '257558', 'ded7ccb2e883d9cdf9debba23727c4d85c6697eea7791f3bec549161a38f01f3');
INSERT INTO `tb_works_files` VALUES (73, 27, 72, 3, 1562574759, 'static/upload/images/20190708/yKLLV6YH.jpeg', 1, 1562574817, '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb', '257558', 'ded7ccb2e883d9cdf9debba23727c4d85c6697eea7791f3bec549161a38f01f3');
INSERT INTO `tb_works_files` VALUES (74, 27, 73, 3, 1562574759, 'static/upload/images/20190708/zBEscAOA.jpeg', 1, 1562575180, '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb', '257558', 'ded7ccb2e883d9cdf9debba23727c4d85c6697eea7791f3bec549161a38f01f3');
INSERT INTO `tb_works_files` VALUES (75, 27, 73, 3, 1562574760, 'static/upload/images/20190708/stpv018j.jpeg', 1, 1562575180, '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb', '257558', 'ded7ccb2e883d9cdf9debba23727c4d85c6697eea7791f3bec549161a38f01f3');
INSERT INTO `tb_works_files` VALUES (76, 27, 74, 3, 1562574760, 'static/upload/images/20190708/N973Nil6.jpeg', 1, 1562584012, '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb', '257558', '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb');
INSERT INTO `tb_works_files` VALUES (77, 27, 75, 3, 1562578869, 'static/upload/images/20190708/oaHe9nLl.jpg', 1, 1562584780, '98c1e108e8b197381be4f5ff7cb5a524338d5d87c966f820ff798c7c5e00db69', '929974', '98c1e108e8b197381be4f5ff7cb5a524338d5d87c966f820ff798c7c5e00db69');
INSERT INTO `tb_works_files` VALUES (78, 27, 0, 3, 1562663764, 'static/upload/images/20190709/4CXEt6Mp.jpg', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (79, 27, 0, 3, 1562664608, 'static/upload/images/20190709/xT5ZSvhe.png', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (80, 27, 0, 3, 1562664611, 'static/upload/images/20190709/d3HK65Ym.png', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (81, 27, 0, 3, 1562664613, 'static/upload/images/20190709/3P1EtvTZ.png', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (82, 27, 0, 3, 1562664635, 'static/upload/images/20190709/UO09SVzP.jpg', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (83, 27, 0, 3, 1562684160, 'static/upload/images/20190709/ISObKdqb.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (84, 27, 0, 3, 1562684160, 'static/upload/images/20190709/hCVIFIPx.jpg', 0, 0, '', '625964', '');
INSERT INTO `tb_works_files` VALUES (85, 27, 0, 3, 1562684316, 'static/upload/images/20190709/GmNCKvvc.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (86, 27, 0, 3, 1562684316, 'static/upload/images/20190709/u02qd17a.jpg', 0, 0, '', '625964', '');
INSERT INTO `tb_works_files` VALUES (87, 27, 0, 3, 1562684404, 'static/upload/images/20190709/bLYbh3yb.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (88, 27, 0, 3, 1562684404, 'static/upload/images/20190709/VXW3XBze.jpg', 0, 0, '', '625964', '');
INSERT INTO `tb_works_files` VALUES (89, 27, 0, 3, 1562684547, 'static/upload/images/20190709/BU26v3ts.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (90, 27, 0, 3, 1562684547, 'static/upload/images/20190709/9i2cX8iN.jpg', 0, 0, '', '625964', '');
INSERT INTO `tb_works_files` VALUES (91, 27, 0, 3, 1562684609, 'static/upload/images/20190709/paFP00u8.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (92, 27, 0, 3, 1562684609, 'static/upload/images/20190709/dOEMzdtR.jpg', 0, 0, '', '625964', '');
INSERT INTO `tb_works_files` VALUES (93, 27, 0, 3, 1562685821, 'static/upload/images/20190709/tZWbKNCU.png', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (94, 27, 0, 3, 1562685821, 'static/upload/images/20190709/XE4h9JKA.jpg', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '625964', '');
INSERT INTO `tb_works_files` VALUES (95, 27, 0, 3, 1562685911, 'static/upload/images/20190709/rZuwmA3G.jpg', 0, 0, 'f01dd983840421f31145577fe5cb3c5adc89a602a82ccb3a416011b807f0cdb4', '941592', '');
INSERT INTO `tb_works_files` VALUES (96, 27, 0, 1, 1562686103, 'static/upload/videos/20190709/4Hyagtje.mov', 0, 0, '9079d319326301aafdd593d345666eb44edb837b8180c92808881f6d5de65b70', '22800258', '');
INSERT INTO `tb_works_files` VALUES (97, 27, 0, 3, 1562686309, 'static/upload/images/20190709/Rcl0PMKd.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (98, 27, 0, 3, 1562686309, 'static/upload/images/20190709/okLktIAm.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (99, 27, 0, 3, 1562686673, 'static/upload/images/20190709/vhaaJgdK.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (100, 27, 0, 3, 1562686673, 'static/upload/images/20190709/8dcfTIIs.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (101, 27, 0, 3, 1562686728, 'static/upload/images/20190709/HPnfB88j.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (102, 27, 0, 3, 1562686728, 'static/upload/images/20190709/lwFxsHhY.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (103, 27, 0, 3, 1562686906, 'static/upload/images/20190709/cZampzAZ.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (104, 27, 0, 3, 1562686906, 'static/upload/images/20190709/ZZyNRr6V.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (105, 27, 0, 3, 1562687040, 'static/upload/images/20190709/VB1DvdQp.png', 0, 0, '', '18522', '');
INSERT INTO `tb_works_files` VALUES (106, 27, 0, 3, 1562687040, 'static/upload/images/20190709/ukR2hAOq.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (107, 27, 0, 3, 1562687052, 'static/upload/images/20190709/tw7bnoEf.png', 0, 0, '', '18522', '');
INSERT INTO `tb_works_files` VALUES (108, 27, 0, 3, 1562687053, 'static/upload/images/20190709/XRbrZ2L6.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (109, 27, 0, 3, 1562687316, 'static/upload/images/20190709/FiSWRFAS.png', 0, 0, '', '18522', '');
INSERT INTO `tb_works_files` VALUES (110, 27, 0, 3, 1562687316, 'static/upload/images/20190709/jZZX692u.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (111, 27, 0, 3, 1562687365, 'static/upload/images/20190709/MiTd5DaG.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (112, 27, 0, 3, 1562687365, 'static/upload/images/20190709/bn2ERjsU.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (113, 27, 0, 3, 1562723110, 'static/upload/images/20190710/kOCkmryy.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (114, 27, 0, 3, 1562723110, 'static/upload/images/20190710/ZaH3UKUp.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (115, 27, 0, 3, 1562723114, 'static/upload/images/20190710/TWKLq69B.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (116, 27, 0, 3, 1562723114, 'static/upload/images/20190710/i94i8oDM.jpg', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '941592', '');
INSERT INTO `tb_works_files` VALUES (117, 27, 0, 3, 1562723307, 'static/upload/images/20190710/Emf1VTTe.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (118, 27, 0, 3, 1562723320, 'static/upload/images/20190710/AiK4e5eC.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (119, 27, 0, 3, 1562723353, 'static/upload/images/20190710/BagmgfPc.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (120, 27, 0, 3, 1562723354, 'static/upload/images/20190710/gFgQ3iPh.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (121, 27, 0, 3, 1562723579, 'static/upload/images/20190710/S1tDccl2.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (122, 27, 0, 3, 1562723579, 'static/upload/images/20190710/f2wvumd1.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (123, 27, 0, 3, 1562723582, 'static/upload/images/20190710/fQRz0RZ3.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (124, 27, 0, 3, 1562723582, 'static/upload/images/20190710/8LuyR4rv.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (125, 27, 0, 3, 1562723583, 'static/upload/images/20190710/6jtaOeuG.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (126, 27, 0, 3, 1562723583, 'static/upload/images/20190710/VpczF3C0.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (127, 27, 0, 3, 1562723583, 'static/upload/images/20190710/ALjmseLY.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (128, 27, 0, 3, 1562723583, 'static/upload/images/20190710/eVLPhOLq.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (129, 27, 0, 3, 1562723584, 'static/upload/images/20190710/R13PH0Sg.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (130, 27, 0, 3, 1562723584, 'static/upload/images/20190710/ZFVkjlZj.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (131, 27, 0, 3, 1562723584, 'static/upload/images/20190710/T3DT47Ol.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (132, 27, 0, 3, 1562723584, 'static/upload/images/20190710/gwqMVTVt.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (133, 27, 0, 3, 1562723584, 'static/upload/images/20190710/2HNCechn.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (134, 27, 0, 3, 1562723584, 'static/upload/images/20190710/gFO5Ms6U.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (135, 27, 0, 3, 1562723584, 'static/upload/images/20190710/BmjCQQ21.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (136, 27, 0, 3, 1562723584, 'static/upload/images/20190710/tM2Cyc3B.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (137, 27, 0, 3, 1562723586, 'static/upload/images/20190710/NSWKhlK1.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (138, 27, 0, 3, 1562723586, 'static/upload/images/20190710/ZKpJw5ZS.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (139, 27, 0, 3, 1562723588, 'static/upload/images/20190710/ITttsqQC.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (140, 27, 0, 3, 1562723589, 'static/upload/images/20190710/hGCkNRES.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (141, 27, 0, 3, 1562723589, 'static/upload/images/20190710/Ehiioxhy.png', 0, 0, '', '436712', '');
INSERT INTO `tb_works_files` VALUES (142, 27, 0, 3, 1562723590, 'static/upload/images/20190710/gM2mjC2u.jpg', 0, 0, '', '941592', '');
INSERT INTO `tb_works_files` VALUES (143, 27, 0, 3, 1562723707, 'static/upload/images/20190710/eFHwxgia.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (144, 27, 0, 3, 1562723707, 'static/upload/images/20190710/xgzjkNCa.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (145, 27, 0, 3, 1562723725, 'static/upload/images/20190710/KbwoYHcc.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (146, 27, 0, 3, 1562723725, 'static/upload/images/20190710/I9xnaF9t.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (147, 27, 0, 3, 1562723726, 'static/upload/images/20190710/0fmCz9zK.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (148, 27, 0, 3, 1562723726, 'static/upload/images/20190710/Fm6HkUQS.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (149, 27, 0, 3, 1562723726, 'static/upload/images/20190710/DDVs3olP.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (150, 27, 0, 3, 1562723727, 'static/upload/images/20190710/iG32Rzlo.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (151, 27, 0, 3, 1562723727, 'static/upload/images/20190710/GXojOfjt.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (152, 27, 0, 3, 1562723727, 'static/upload/images/20190710/Hju64Hyh.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (153, 27, 0, 3, 1562723728, 'static/upload/images/20190710/JKXW18jI.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (154, 27, 0, 3, 1562723728, 'static/upload/images/20190710/LcCCuK2v.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (155, 27, 0, 3, 1562723827, 'static/upload/images/20190710/NQUWsv7d.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (156, 27, 0, 3, 1562723827, 'static/upload/images/20190710/wbVFPhy2.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (157, 27, 0, 3, 1562723874, 'static/upload/images/20190710/JslYpCzu.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (158, 27, 0, 3, 1562723874, 'static/upload/images/20190710/sToCCCbX.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (159, 27, 0, 3, 1562723882, 'static/upload/images/20190710/kNsKPTwZ.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (160, 27, 0, 3, 1562723882, 'static/upload/images/20190710/jj2kiEIv.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (161, 27, 0, 3, 1562723882, 'static/upload/images/20190710/alOWvg4Z.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (162, 27, 0, 3, 1562723883, 'static/upload/images/20190710/D4Qb0oVX.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (163, 27, 0, 3, 1562723883, 'static/upload/images/20190710/JoSeOU9i.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (164, 27, 0, 3, 1562723883, 'static/upload/images/20190710/oDBXbtiX.jpg', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '941592', '');
INSERT INTO `tb_works_files` VALUES (165, 27, 0, 3, 1562723961, 'static/upload/images/20190710/1xRyvI6P.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (166, 27, 0, 3, 1562727922, 'static/upload/images/20190710/rc96WD9V.png', 0, 0, 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855', '436712', '');
INSERT INTO `tb_works_files` VALUES (167, 27, 0, 3, 1562728048, 'static/upload/images/20190710/msO3hufZ.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (168, 27, 0, 3, 1562728048, 'static/upload/images/20190710/6z8FJK5H.jpg', 0, 0, 'f01dd983840421f31145577fe5cb3c5adc89a602a82ccb3a416011b807f0cdb4', '941592', '');
INSERT INTO `tb_works_files` VALUES (169, 27, 0, 3, 1562728160, 'static/upload/images/20190710/eKPlREKd.png', 0, 0, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '');
INSERT INTO `tb_works_files` VALUES (170, 27, 0, 3, 1562728160, 'static/upload/images/20190710/NKE4lpz1.jpg', 0, 0, 'f01dd983840421f31145577fe5cb3c5adc89a602a82ccb3a416011b807f0cdb4', '941592', '');
INSERT INTO `tb_works_files` VALUES (171, 27, 76, 3, 1562728214, 'static/upload/images/20190710/eUIB5eKS.png', 1, 1562728886, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '1377e68f255a80f7475aba46f0c4a232410424b15302cce63b9f24d9866ce517');
INSERT INTO `tb_works_files` VALUES (172, 27, 76, 3, 1562728214, 'static/upload/images/20190710/9AfYkws4.jpg', 1, 1562728886, 'f01dd983840421f31145577fe5cb3c5adc89a602a82ccb3a416011b807f0cdb4', '941592', '1377e68f255a80f7475aba46f0c4a232410424b15302cce63b9f24d9866ce517');
INSERT INTO `tb_works_files` VALUES (173, 27, 76, 3, 1562728214, 'static/upload/images/20190710/hEuwt8D7.jpeg', 1, 1562728886, '9b2ea30b63c10682c50ac2a2bb093031a86357feda8fb5293e2642f22e34f7bb', '257558', '1377e68f255a80f7475aba46f0c4a232410424b15302cce63b9f24d9866ce517');
INSERT INTO `tb_works_files` VALUES (174, 27, 77, 1, 1562741337, 'static/upload/videos/20190710/AGC1jbso.mov', 1, 1562741378, '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d', '22826143', '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d');
INSERT INTO `tb_works_files` VALUES (175, 27, 0, 3, 1562758653, 'static/upload/images/20190710/ltKA6abX.png', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (176, 27, 0, 3, 1562758726, 'static/upload/images/20190710/0mCxoZFA.png', 0, 0, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', '');
INSERT INTO `tb_works_files` VALUES (177, 27, 0, 3, 1562759593, 'static/upload/images/20190710/uiVMlNZI.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (178, 27, 0, 3, 1562759611, 'static/upload/images/20190710/i1iiKWLE.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (179, 27, 0, 3, 1562759611, 'static/upload/images/20190710/GN2vPApf.jpg', 0, 0, '98c1e108e8b197381be4f5ff7cb5a524338d5d87c966f820ff798c7c5e00db69', '929974', '');
INSERT INTO `tb_works_files` VALUES (180, 27, 0, 1, 1562835084, 'static/upload/videos/20190711/u0ojxLrc.mov', 0, 0, 'c8629b1cc7deb6940e81998ccc3f1854bac641b47807f7bb728641c3e9a223fd', '6768845', '');
INSERT INTO `tb_works_files` VALUES (181, 27, 0, 3, 1563160724, 'static/upload/images/20190715/vOewOBZ4.jpg', 0, 0, '31dc74eb7764482c16eb3a9f5d1a79c11d13a6471913cb20951938a158cef3b1', '966127', '');
INSERT INTO `tb_works_files` VALUES (182, 27, 0, 1, 1563161959, 'static/upload/videos/20190715/8Kkg0LCg.mov', 0, 0, '199fe86d010983ffd5fb7defa3114dd2a5c59be7b0b8c6d827c00826f97bd360', '112336736', '');
INSERT INTO `tb_works_files` VALUES (183, 27, 0, 5, 1563162281, 'static/upload/verified/personal/20190715/lXO7fhey.pdf', 0, 0, '', '4300117', '');
INSERT INTO `tb_works_files` VALUES (184, 27, 0, 5, 1563162341, 'static/upload/verified/enterprise/entrust/20190715/pP4nOh0h.pdf', 0, 0, '', '4300117', '');
INSERT INTO `tb_works_files` VALUES (185, 27, 0, 5, 1563162343, 'static/upload/verified/enterprise/entrust/20190715/JnxEn6H6.pdf', 0, 0, '', '4300117', '');
INSERT INTO `tb_works_files` VALUES (186, 27, 0, 3, 1563256187, 'static/upload/images/20190716/O9g2joSG.png', 0, 0, '234ca16dd75b5980664a63ccbd63a7bbb34a6649cbbd229c4f9f5d69059fb8e0', '18522', '');
INSERT INTO `tb_works_files` VALUES (187, 27, 0, 3, 1563256864, 'static/upload/images/20190716/RZXbPM0P.PNG', 0, 0, '19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330', '96972', '');
INSERT INTO `tb_works_files` VALUES (188, 27, 80, 3, 1563257000, 'static/upload/images/20190716/nnigMroW.PNG', 1, 1563352530, '19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330', '96972', '19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330');
INSERT INTO `tb_works_files` VALUES (189, 27, 79, 3, 1563257276, 'static/upload/images/20190716/z2yzLrsE.png', 1, 1563278965, '19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330', '96972', '19771f39b9283a75ed456e5fd9a12692654d20606963fd6ff9176d2558f07330');
INSERT INTO `tb_works_files` VALUES (190, 27, 78, 5, 1563257327, 'static/upload/verified/personal/20190716/WDUqEMVq.png', 1, 1563259497, '', '15089', 'd8156bae0c4243d3742fc4e9774d8aceabe0410249d720c855f98afc88ff846c');
INSERT INTO `tb_works_files` VALUES (191, 27, 78, 5, 1563257344, 'static/upload/verified/personal/20190716/CSDMfMG9.png', 1, 1563259497, '', '96972', 'd8156bae0c4243d3742fc4e9774d8aceabe0410249d720c855f98afc88ff846c');
INSERT INTO `tb_works_files` VALUES (192, 38, 0, 5, 1564127225, 'static/upload/verified/personal/20190726/ECNiBsl5.png', 0, 0, '', '18522', '');
INSERT INTO `tb_works_files` VALUES (193, 38, 82, 3, 1564127382, 'static/upload/images/20190726/NSG8JBrR.png', 1, 1564128839, '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791', '436712', '1aee5c431c1b2008a59bd1bc955dd5b1ac0d1c6425ab1c469235181955189791');
INSERT INTO `tb_works_files` VALUES (194, 40, 0, 5, 1564132246, 'static/upload/verified/personal/20190726/gYIM5UGu.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (195, 40, 83, 3, 1564132294, 'static/upload/images/20190726/RQdbCXCL.png', 1, 1564132307, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da');
INSERT INTO `tb_works_files` VALUES (196, 40, 84, 3, 1564134234, 'static/upload/images/20190726/EqtxP9tP.png', 1, 1564134245, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da');
INSERT INTO `tb_works_files` VALUES (197, 27, 0, 5, 1564372338, 'static/upload/verified/personal/20190729/TsD2nt48.png', 0, 0, '', '15089', '');
INSERT INTO `tb_works_files` VALUES (198, 40, 85, 3, 1564563095, 'static/upload/images/20190731/7DDrtVOe.png', 1, 1564563107, 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da', '15089', 'c7fc7f463ca9f401628e855ac8af966ddbd5e83a89d6994f6002f982971046da');
INSERT INTO `tb_works_files` VALUES (199, 27, 0, 1, 1566039995, 'static/upload/videos/20190817/Jp9hcXkb.mov', 0, 0, '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d', '22826143', '');
INSERT INTO `tb_works_files` VALUES (200, 27, 0, 1, 1566040501, 'static/upload/videos/20190817/nANUWYLk.mov', 0, 0, '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d', '22826143', '');
INSERT INTO `tb_works_files` VALUES (201, 27, 87, 1, 1566040505, 'static/upload/videos/20190817/etKBiAMu.mov', 1, 1566111753, '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d', '22826143', '0f09f536f725af18a1852e5124a9a79690a45d1c5d2eb6ec01fc13cab98a1e8d');
INSERT INTO `tb_works_files` VALUES (202, 27, 86, 1, 1566040566, 'static/upload/videos/20190817/Ovi93vor.mov', 1, 1566040827, '9079d319326301aafdd593d345666eb44edb837b8180c92808881f6d5de65b70', '22800258', '9079d319326301aafdd593d345666eb44edb837b8180c92808881f6d5de65b70');
COMMIT;

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

-- ----------------------------
-- Records of tb_works_news
-- ----------------------------
BEGIN;
INSERT INTO `tb_works_news` VALUES (1, 27, 55, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562316159, 1, 1);
INSERT INTO `tb_works_news` VALUES (2, 27, 69, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562572528, 1, 1);
INSERT INTO `tb_works_news` VALUES (3, 27, 70, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562573656, 1, 1);
INSERT INTO `tb_works_news` VALUES (4, 27, 71, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562574689, 1, 1);
INSERT INTO `tb_works_news` VALUES (5, 27, 72, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562574851, 1, 1);
INSERT INTO `tb_works_news` VALUES (6, 27, 73, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562575259, 1, 1);
INSERT INTO `tb_works_news` VALUES (7, 27, 74, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562584046, 1, 1);
INSERT INTO `tb_works_news` VALUES (8, 27, 75, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562584802, 1, 1);
INSERT INTO `tb_works_news` VALUES (9, 27, 76, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562728916, 1, 1);
INSERT INTO `tb_works_news` VALUES (10, 27, 77, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1562741396, 1, 1);
INSERT INTO `tb_works_news` VALUES (11, 27, 78, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1563259525, 1, 1);
INSERT INTO `tb_works_news` VALUES (12, 27, 79, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1563278972, 1, 1);
INSERT INTO `tb_works_news` VALUES (13, 27, 80, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1563352590, 1, 1);
INSERT INTO `tb_works_news` VALUES (14, 38, 81, '183****958@qq.com刚刚申请办理了[版权存证]业务', '183****958@qq.com刚刚申请办理了[版权存证]业务', 1564128713, 1, 1);
INSERT INTO `tb_works_news` VALUES (15, 38, 82, '183****958@qq.com刚刚申请办理了[版权存证]业务', '183****958@qq.com刚刚申请办理了[版权存证]业务', 1564128899, 1, 1);
INSERT INTO `tb_works_news` VALUES (16, 40, 83, '178****6239刚刚申请办理了[版权存证]业务', '178****6239刚刚申请办理了[版权存证]业务', 1564132344, 1, 1);
INSERT INTO `tb_works_news` VALUES (17, 40, 84, '178****6239刚刚申请办理了[版权存证]业务', '178****6239刚刚申请办理了[版权存证]业务', 1564134256, 1, 1);
INSERT INTO `tb_works_news` VALUES (18, 40, 85, '178****6239刚刚申请办理了[版权存证]业务', '178****6239刚刚申请办理了[版权存证]业务', 1564563136, 1, 1);
INSERT INTO `tb_works_news` VALUES (19, 27, 86, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1566111891, 1, 1);
INSERT INTO `tb_works_news` VALUES (20, 27, 87, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1566111893, 1, 1);
INSERT INTO `tb_works_news` VALUES (21, 27, 86, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1566135776, 1, 1);
INSERT INTO `tb_works_news` VALUES (22, 27, 86, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1566136479, 1, 1);
INSERT INTO `tb_works_news` VALUES (23, 27, 86, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1566136660, 1, 1);
INSERT INTO `tb_works_news` VALUES (24, 27, 86, '123****qq.com刚刚申请办理了[版权存证]业务', '123****qq.com刚刚申请办理了[版权存证]业务', 1566136732, 1, 1);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
