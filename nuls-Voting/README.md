# 基于nuls的投票系统 nuls-voting

## 核心功能
模块实现的核心业务是在nuls上建立投票选举事件，应征候选人，并让选举人对候选人进行投票，最后公布投票选举结果

## Core functions

 1. 为每个投票选举事件建立独立的链
 
 2. 为每个应征的候选人指定一个唯一不重复的投票地址
 
 3. 给每个投票人发放选票(某个数量的token)
 
 4. 在应征候选人阶段，候选人可以上传自己的介绍和作品链接。投票开始前，截止应征作品修改,将会把加密后的候选人应征作品内容存储在链上和节点文件系统中
 
 5. 当投票开始后，投票人可以把手里的选票投给喜欢的候选人
 
 6. 当投票结束后，投票选举结果向所有用户公示
 
 注：投票选举活动发起人空投给每个选举人选票将会产生的费用，为了控制整体费用，可以加入智能合约进行选举人资格筛选。

## 次要功能点

 1. 查看投票选举事件列表
 
 2. 查看候选人列表
 
 3. 投票开始后查看每个候选人的得票情况
 
## General design
  1. roles
  
     admin：
     
     vote hosts：
     
        create and manage the vote events
        
     candidates：
     
         the people who have achievement to be vote
         
     attends：
     
        vote for the candidates
        
        
  2. sinario
     
     vote host regist and login create a new vote event( title,description,Electoral nominations start time ,end time,vote start time and so on)
     
     during Electoral nominations time
     
     candidates  regist and login upload his achievement
     
     when vote starts
     
     attends  regist and login get free tickes ,vote for candidates
     
     when vote ehds
     
     vote host get Voting statistics,and all uses can see the result
     
  3. functions and api
  
    public functions
    
      register and login
      
      001.  api 手机短信认证
      
      002.  api 注册
      
      003.  api 登录
       
       
    public square show all vote events
    
      101. api 取得所有选举事件
     
    all votes past comming and in the furch
    
      102. api 按时间检索选举事件
     
    personal center(ID card identification)
    
      201. api 实名认证
     
     my attend(我参加的选举)votes and my host(我举办的选举)votes.  
     
      202. api 按照我参加的和我举办的 取得选举
     
     create new votes 
     
      301. api 新建选举
     
     to be candidates
     
      401. api 参加候选人报名资料上传(或者填写推荐人/推荐码)
      
     vote 
      
      501. api 投票开始候选人成果公示
      
      502. api voteing 选民投票
        
     
    acccecs and get tickes for vote
      
      601. api vote host get the Voting statistics
    
    vote result
    
      701. api all the user get the result for this vote event
     
 
前端设计原型：
    https://teymyp.axshare.com
    密码：wanghaoxiang

与后端交互api设计：
apidoc: http://nulsvoting.wanghx.top/phalapi/public/docs.php  接口文档自动生成，mysql数据库建表语句在model类里

## 开发/测试环境搭建步骤：

1. 智能合约开发：https://docs.nuls.io/zh/Docs/s_manual.html

     选举事件智能合约 votingNRC20 代码在 java目录下
     
     生成的hex code 通过nuls-api发布智能合约接口发布
     
     nuls-api 文档 https://docs.nuls.io/zh/Docs/s_manual.html#_6-智能合约主要的api
     
      这里用到 NULS-API_RESTFUL 接口

2. 中心化服务器 nginx(apache,iis),mysql5.5以上 ，php 5.5以上，存储不上链的数据

3. 安装php的restfullapi框架phalapi2.0，开发调试api: http://docs.phalapi.net/#/v2.0/



   已搭建中心化服务器api服务器地址: http://nulsvoting.wanghx.top/phalapi/public/docs.php
   
   接口文档自动生成，mysql数据库建表语句在model类里
   
   上传的代码是src里面的自己开发的代码，放入 phaapi的对应目录可以运行得到结果
   
   
   
   前端h5示例页面 http://nulsvoting.wanghx.top/h5/
   代码在H5目录下
   
4. 合约调试步骤

   下载nuls钱包，新建测试账户，联系技术群客服充值测试币

   安装postman，导入接口设置文件

   用到的nulsapi接口在postman上连接测试网进行测试，http://beta.api.nuls.io

       1. 根据私钥导入测试账户api/account/import/pri

       2. 查看余额 api/accountledger/balance/{acccount}

       3. 发布智能合约的code  api/contract/create

       4. 批量新建 候选人账户  api/account    prefix：candi  每次新建1个

       5. 批量新建 投票人账户  api/account    prefix: voter  每次新建1个
       
       6. 空投选票 api/contract/call   使用votingNRC20  的自定义  nulstransfer 和 nulstransferfrom 方法，转账的 type类型 为 'a'
  
       7. 投票转账 api/contract/call   使用votingNRC20  的自定义 nulstransfer 和 nulstransferfrom 方法，转账的 type类型 为 'b'

       8. 统计候选人选票账户结果 由中心化数据库取得当前投票事件中给候选人投票(vote表)的所有记录，
          
          逐条通过 api/accountledger/transaction/validate 用交易号作为参数 进行验证，验证通过后，按不同候选人分组统计票数(votingNRC20币)，按照降序分页输出结果。次功能可以在 中心化服务器中实现，或者封装成 独立模块通过chainbox发布，但需要给 nuls-api模块增加相应的接口
       
       
       
## 前端在H5目录下

1. H5的使用

搭建您的web服务器（nginx或者apache ，IIS都可以）

把整个 h5目录复制到 网站根目录下，（例： http://localhost/h5） 打开页面，使用谷歌浏览器开发者工具切换到手机移动端视图就可以看到了

2. H5 的开发环境

安装 HbuilderX，新建 uni-app项目。发布为h5项目

3. uni-app 源码

uniappcode.zip  是 uni-app源码，用 HBUILDERX 开发


示例网址 http://nulsvoting.wanghx.top/h5/  用手机访问或者  谷歌 的手机浏览方式

