<?php
namespace App\Model\Vote;
use PhalApi\Model\NotORMModel as NotORM;
/*
 CREATE TABLE `candidate` (
  `id` mediumint(11) NOT NULL,
  `user_id` mediumint(11) NOT NULL COMMENT '用户id',
  `vote_event_id` mediumint(11) NOT NULL COMMENT '投票事件id',
  `introduce` varchar(500) COLLATE utf8_unicode_ci NOT NULL COMMENT '候选介绍',
  `resource` varchar(500) COLLATE utf8_unicode_ci NOT NULL COMMENT '候选资源',
  `tickes` mediumint(15) NOT NULL DEFAULT '0' COMMENT '得票数',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '审核状态',
  `account_address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '候选人账户',
  `trans_addr` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'nuls事务处理编号',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
*/
class Candidate extends NotORM {
	protected function getTableName($id) {
        return 'candidate';
    }

   
 
}

