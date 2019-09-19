<?php
namespace App\Domain\Vote;

use App\Model\Vote\VoteEvent as ModelVoteEvent;
use App\Model\Vote\Candidate as ModelCandidate;
use App\Model\Vote\Voter as ModelVoter;
use App\Model\Vote\Vote as ModelVote;

class Vote {

    public function createVoteEvent($newData) {
       
        $model = new ModelVoteEvent();
        return $model->insert($newData);
    }

    public function createCandidate($newData) {
        $model = new ModelCandidate();
        return $model->insert($newData);
    }


    public function createVoter($newData) {
        $model = new ModelVoter();
        return $model->insert($newData);
    }

    public function createVote($newData) {
        \PhalApi\DI()->notorm->beginTransaction('db_master');
        // 做事务处理
        //先检查该选民是否投过该候选人的票
        //todo 先取得voter表选民的剩余票数是否大于0
        //然后 voter表该投票选民剩余票数减一，候选人表Candidate该候选人得票数加一
        //最后投票记录表增加一条记录
        $model = new ModelVote();
        $rst = $model->insert($newData);

        \PhalApi\DI()->notorm->commit('db_master');
        return $rst;

    }

    // public function update($newData) {
    //     $model = new ModelVote();
    //     return $model->update($id, $newData);
    // }

    // public function get($id) {
    //     $model = new ModelVote();
    //     return $model->get($id);
    // }

    // public function delete($id) {
    //     $model = new ModelVote();
    //     return $model->delete($id);
    // }

    // public function getList($state, $page, $perpage) {
    //     $rs = array('items' => array(), 'total' => 0);

    //     $model = new ModelCURD();
    //     $items = $model->getListItems($state, $page, $perpage);
    //     $total = $model->getListTotal($state);

    //     $rs['items'] = $items;
    //     $rs['total'] = $total;

    //     return $rs;
    // }
}
