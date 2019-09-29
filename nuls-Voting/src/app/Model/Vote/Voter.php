<?php
namespace App\Model\Vote;
use PhalApi\Model\NotORMModel as NotORM;
/*
CREATE TABLE `voter` (
  `id` mediumint(11) NOT NULL,
  `user_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `vote_event_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '审核状态',
  `total_ticket` smallint(2) NOT NULL DEFAULT '5' COMMENT '总选票数',
  `remain_tickets` smallint(2) NOT NULL DEFAULT '5' COMMENT '剩余选票数',
  `account_address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '账户地址',
  `trans_code` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'nuls事务处理编号',
  `update_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


*/
class Voter extends NotORM {
	protected function getTableName($id) {
        return 'voter';
    }

   
 
}

