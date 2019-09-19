## 用于voting事件，加了字段的NRC20智能合约

## 初始化新建合约的时候，增加了 

 1. detail 介绍选举事件，
 
 2. resource 放置 其他资源 ，
 
 3. md5forvotingevent 所有字段的签名
 
 可能还要追加 候选人征集开始/结束时间，投票开始/结束时间

## 增加了

  1. votingTransfer方法
 
   2.votingTransferFrom 方法
  
 
    这两个方法比原先方法多传入 
    
    1. transfertype : 'a': 账户空投选票(发行的NRC20币)，无论候选人或选民，账户建立后 都空投相同数量的 应选的选举活动发行NRC20币
    
                      'b': 投票行为转账，由选民转给候选人
                      
    2. votecontractaddr : 投票事件的智能合约地址
    
    3. introduce ： (transfertype : 'a')在候选人应征成功，空投给候选人选票的时候，这里放置候选作品介绍。 候选人的空投选票默认在选举开始后投给自己。
    
                    其他情况下 为空
              
    4. resource ： 同 introduce ，放置 候选人应选作品的其他资源
    
    5. md5remark ： 同 introduce ，放置所有信息的防伪MD5签名
    
    
