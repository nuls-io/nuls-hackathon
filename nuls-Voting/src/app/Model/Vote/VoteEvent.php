<?php
namespace App\Model\Vote;
use PhalApi\Model\NotORMModel as NotORM;
/*
 CREATE TABLE `vote_event` (
  `id` mediumint(11) NOT NULL,
  `user_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL COMMENT '创建人id',
  `title` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '标题',
  `detail` varchar(500) COLLATE utf8_unicode_ci NOT NULL COMMENT '详细',
  `resource` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `candi_start_time` timestamp(6) NULL DEFAULT '0000-00-00 00:00:00.000000' COMMENT '候选人报名开始时间',
  `candi_end_time` timestamp(6) NULL DEFAULT '0000-00-00 00:00:00.000000',
  `vote_start_time` timestamp(6) NULL DEFAULT '0000-00-00 00:00:00.000000',
  `vote_end_time` timestamp(6) NULL DEFAULT '0000-00-00 00:00:00.000000' COMMENT '投票结束时间',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '审核状态',
  `contract_addr` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'nulsNRC20智能合约地址',
  `trans_addr` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'nuls事务编号',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

*/
class VoteEvent extends NotORM {

  protected function getTableName($id) {
        return 'vote_event';
    }

 
}

