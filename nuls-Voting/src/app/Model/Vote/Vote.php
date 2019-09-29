<?php
namespace App\Model\Vote;
use PhalApi\Model\NotORMModel as NotORM;
/*
CREATE TABLE `vote` (
  `id` mediumint(11) NOT NULL,
  `vote_event_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `contact_address` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '智能合约地址',
  `candidate_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `candi_account` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '候选人账户',
  `voter_id` varchar(11) COLLATE utf8_unicode_ci NOT NULL,
  `voter_account` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '选民账户',
  `trans_addr` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'nuls投票事件编号',
  `create_time` timestamp(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
*/
class Vote extends NotORM {
	protected function getTableName($id) {
        return 'vote';
    }

   
 
}

