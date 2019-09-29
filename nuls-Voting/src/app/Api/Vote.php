<?php
namespace App\Api;
use PhalApi\Api;
use App\Domain\Vote\Vote as DomainVote;

class Vote extends Api {

     public function getRules() {
        return array(
            'newVoting' => array(
                'user_id' => array('name' => 'user_id','require' => true, 'min' => 1, 'max' => '11', 'desc' => '用户ID,测试用从50000000000开始往后编号'),
                'title' => array('name' => 'title', 'require' => true, 'min' => 1, 'max' => '50', 'desc' => '选举事件标题'),
                'detail' => array('name' => 'detail', 'require' => true, 'min' => 1, 'max' => '500','desc' => '竞选内容'),
                'resource' => array('name' => 'resource', 'require' => true, 'min' => 1, 'max' => '500','desc' => '竞选资源'),
            ),
            'newCandidate' => array(
                'user_id' => array('name' => 'user_id','require' => true, 'min' => 1, 'max' => '11', 'desc' => '用户ID,测试用从50000000000开始往后编号'),
                'vote_event_id' => array('name' => 'vote_event_id','require' => true, 'min' => 1, 'max' => '11', 'desc' => '投票事件ID,newVoting返回的生成的id'),
                'introduce' => array('name' => 'introduce', 'require' => true, 'min' => 1, 'max' => '500','desc' => '竞选项目'),
                'resource' => array('name' => 'resource', 'require' => true, 'min' => 1, 'max' => '500','desc' => '竞选项目资源'),
               
            ),
            'newVoter' => array(
                'user_id' => array('name' => 'user_id','require' => true, 'min' => 1, 'max' => '11', 'desc' => '用户ID,测试用从50000000000开始往后编号'),
                'vote_event_id' => array('name' => 'vote_event_id','require' => true, 'min' => 1 , 'max' => '11', 'desc' => '投票事件ID,newVoting返回的生成的id'),
            ),
            'vote' => array(
                'voter_id' => array('name' => 'voter_id','require' => true, 'min' => 1, 'max' => '11', 'desc' => '选民ID,newVoter 生成返回的id'),
                'vote_event_id' => array('name' => 'vote_event_id','require' => true, 'min' => 1, 'max' => '11', 'desc' => '投票事件ID,newVoting返回的生成的id'),
                'candidate_id' => array('name' => 'candidate_id','require' => true, 'min' => 1 , 'max' => '11', 'desc' => '候选人ID,newCandidate返回的生成的id'),
            ),
            
        );
    }

    /**
     * 新建投票事件
     * @desc 新建投票事件
     * @return int id 新建事件的数据库主键，大于等于1成功，0表示失败
     */
    public function newVoting(){
    //向http://39.98.226.51:18004/api/contract/create 接口新建NRC20合约
    //     try {
    // // 实例化时也可指定失败重试次数，这里是2次，即最多会进行3次请求
    //         $curl = new \PhalApi\CUrl(2);

    // // 第二个参数为待POST的数据；第三个参数表示超时时间，单位为毫秒
    //         $param = array(
    //             'sender' => '',
    //             'gasLimit' => 23000,
    //             'price' => 25,
    //             'password' => '',
    //             'remark' => 'md5ofvoteevent',
    //             'contractCode' => '',  // 此处参照 NRC20智能合约的contractCode 
    //             'alias' => 'nulsvoting',
    //             'args' => ["nuls","NV", "EVENTMARKNOTNULL","TRANSFORMARKCANNULL",80000, 1],

    //         );
    //         $rs = $curl->post('http://39.98.226.51:18004/api/contract/create/?', $param, 3000);

    // // 判断输出是否成功，成功的话写入本地数据库
    //     echo $rs;
        $rs = array();
       // todo 中心化数据库 加入创建成功的智能合约地址和 MD5防伪签名 以及处理事务号
        $newData = array(
            'user_id' => $this->user_id,
            'title' => $this->title,
            'detail' => $this->detail,
            'resource' => $this->resource,
        );

        $domain = new DomainVote();
        $id = $domain->createVoteEvent($newData);

        $rs['id'] = $id;
        return $rs; 


    //     } catch (\PhalApi\Exception\InternalServerErrorException $ex) {
    // // 错误处理……
    //     }

    //向中性化数据库写入
      
    }
 
    /**
     * 增加候选人
     * @desc 为某投票事件增加一个候选人
     * @return int id 增加的候选人数据库主键，大于等于1成功，0表示失败
     */
    public function newCandidate(){
       //todo 调用nulsapi批量创建账户接口  http://39.98.226.51:18004/api/account
    //     try {
    // // 实例化时也可指定失败重试次数，这里是2次，即最多会进行3次请求
    // $curl = new \PhalApi\CUrl(2);

    // // 第二个参数为待POST的数据；第三个参数表示超时时间，单位为毫秒
        // $param = array(
        //     'count' => 1,
        //     'prefix' => 'candi',
        //     'password' => 'userpwd',
        // );

    // $rs = $curl->post('http://39.98.226.51:18004/api/account/?', $param, 3000);

    // // 一样的输出
    // echo $rs;
    // } catch (\PhalApi\Exception\InternalServerErrorException $ex) {
    // // 错误处理……
    // }


        $rs = array();

        $newData = array(
            'user_id' => $this->user_id,
            'vote_event_id' => $this->vote_event_id,
            'introduce' => $this->introduce,
            'resource' => $this->resource,
        );

        $domain = new DomainVote();
        $id = $domain->createCandidate($newData);

        $rs['id'] = $id;
        return $rs; 
    }

    /**
     * 增加选民
     * @desc 为某投票事件增加一个选民
     * @return int id 增加的选民数据库主键，大于等于1成功，0表示失败
     */
    public function newVoter(){
        //todo 同newCandidate，调用nulsapi批量创建账户接口  http://39.98.226.51:18004/api/account
        // $param = array(
        //     'count' => 1,
        //     'prefix' => 'voter',
        //     'password' => 'userpwd',
        // );

        $rs = array();

        $newData = array(
            'user_id' => $this->user_id,
            'vote_event_id' => $this->vote_event_id,
        );

        $domain = new DomainVote();
        $id = $domain->createVoter($newData);

        $rs['id'] = $id;
        return $rs; 
    } 


    /**
     * 进行投票
     * @desc 某选民为某投票事件的某候选人投票
     * @return int id 新建投票记录数据库主键，大于等于1成功，0表示失败
     */

    public function vote(){
        //todo nulsapi调用合约接口，http://39.98.226.51:18004/api/contract/call
         //     try {
    // // 实例化时也可指定失败重试次数，这里是2次，即最多会进行3次请求
    // $curl = new \PhalApi\CUrl(2);

    // // 第二个参数为待POST的数据；第三个参数表示超时时间，单位为毫秒
        // $param = array(
        //   "sender" : "", //有nuls币的商户
        //   "gasLimit" : 25000,
        //   "price" : 25,
        //   "password" : "",
        //   "remark" : "",
        //   "contractAddress" : "",//从vote_event数据表取得投票事件的智能合约地址
        //   "value" : 0,
        //   "methodName" : "transferFrom",
        //   "methodDesc" : "",
        //   "args" : ["选民账户地址","候选人账户地址",100] //假设每个选票单位是100
        // );

    // $rs = $curl->post('http://39.98.226.51:18004/api/contract/call/?', $param, 3000);

    // // 一样的输出
    // echo $rs;
    // } catch (\PhalApi\Exception\InternalServerErrorException $ex) {
    // // 错误处理……
    // }

        $rs = array();

        $newData = array(
            'voter_id' => $this->voter_id,
            'vote_event_id' => $this->vote_event_id,
            'candidate_id' => $this->candidate_id,
        );

        $domain = new DomainVote();
        $id = $domain->createVote($newData);

        $rs['id'] = $id;
        return $rs; 
    }
}
