# NULS ChainBox
## NULS ChainBox是什么

ChainBox是一个快速搭建区块链的工具，封装了账本，账户，交易，区块，共识，网络六个底层模块，屏蔽了分布式数据存储、点对点传输、共识机制、加密算法等复杂区块链技术，开发者可使用它实现分钟级搭建TPS达1000的基础链，或根据标准通信协议开发业务模块，然后通过chainbox驱动组成一条全新的应用链

## 为什么需要ChainBox
 NULS ChainBox设计的初衷是帮助企业或应用开发者在区块链上能快速构建应用，并专注自己的业务实现，无需关心晦涩、复杂的区块链底层技术。


## 特点
NULS ChainBox本质上是NULS2.0的一个扩展应用，它的定位是一站式区块链开发平台，它有3个核心特点：

- 快速搭建开发环境

- 通过模板降低应用开发门槛

- 通过约定和脚本降低模板集成的难度，实现一键生成可运行程序

## 快速体验
在下面这个case中，你将体验到如何使用NULS ChainBox快速构建一套提供加密邮件服务的区块链应用

### 1 环境准备

- linux内核的操作系统
- 安装 Git
- 安装Maven
- 安装JDK11

### 2 获取NULS ChainBox

打开终端，执行以下命令

```
git clone https://github.com/nuls-io/nuls-chainbox.git chainbox
```
### 3 构建短视保java业务模块
生成业务模块命令：

```
tools -t java-module copyright #新建名为copyright的业务模块
```
执行命令进入copyright目录

```
cd copyright   #进入示例文件夹
```
执行命令构建模块

```
./package    #执行构建脚本（模板提供）
```

看到以下输出后，说明构建完成

```
============ PACKAGE FINISH 🍺🍺🍺🎉🎉🎉 ===============
```

构建成功后会在copyright中生成outer文件夹

> PS:如果你想知道该模块是如何设计的，请查看[加密邮件模块设计文档](./example/模块设计文档.md)

### 4 集成短保业务模块
回到chainbox根目录

```
cd ..
```

执行命令，集成加密模块到NULS2.0运行环境中

```
./tools -p copyright
```
看到以下输出后，说明集成成功

```
============ PACKAGE FINISH 🍺🍺🍺🎉🎉🎉 ===============
```

完成后在chainbox目录下会生成NULS-WALLET文件夹，此文件夹包含了集成了加密邮件模块的NULS2.0运行程序

若在不同机器部署了多个节点，建议修改NULS-WALLET/.default-config.ncf配置文件中的以下两个参数

```
#最小链接节点数,当链接到的网络节点低于此参数时,会持续等待
minNodeAmount=0
#种子节点出块地址
seedNodes=tNULSeBaMkrt4z9FYEkkR9D6choPVvQr94oYZp
```

### 5 启动节点程序
配置完成后，在NULS-WALLET目录执行以下命令

```
./start-dev

```
看到以下内容说明模块正在启动中

```
LOG PATH    : ~/NULS-WALLET/Logs
DATA PATH   : ~/NULS-WALLET/data
CONFIG FILE : ~/NULS-WALLET/nuls.ncf
DEBUG       : 0
JAVA_HOME   : /Library/java/JavaVirtualMachines/jdk-11.0.2.jdk/Contents/Home
java version "11.0.2" 2019-01-15 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.2+9-LTS, mixed mode)

====================
NULS-WALLET STARING
====================
```

可通过以下命令检查模块启动情况

```
./check-status 
```
看到以下内容表示节点模块已全部启动成功

```
==================MODULE PROCESS====================
account PROCESS IS START
block PROCESS IS START
consensus PROCESS IS START
ledger PROCESS IS START
network PROCESS IS START
transaction PROCESS IS START
==================RPC REDAY MODULE==================
account RPC READY
block RPC READY
consensus RPC READY
ledger RPC READY
network RPC READY
transaction RPC READY
======================REDAY MODULE==================
account STATE IS READY
block STATE IS READY
consensus STATE IS READY
ledger STATE IS READY
network STATE IS READY
transaction STATE IS READY
================TRY RUNNING MODULE==================
account TRY RUNNING
block TRY RUNNING
consensus TRY RUNNING
ledger TRY RUNNING
network TRY RUNNING
transaction TRY RUNNING
===================RUNNING MODULE===================
account STATE IS RUNNING
block STATE IS RUNNING
consensus STATE IS RUNNING
ledger STATE IS RUNNING
network STATE IS RUNNING
transaction STATE IS RUNNING
==================NULS WALLET STATE=================
==========================
NULS WALLET IS RUNNING
==========================
```

### 7 导入种子节点出块地址
现在种子节点已经启动，我们需进入命令行导入默认的种子出块地址，让节点开始出块

首先进入命令行

```
./cmd 
```
导入出块地址

```
nuls>>> import 477059f40708313626cccd26f276646e4466032cabceccbf571a7c46f954eb75 #通过私钥导入种子节点地址,密码默认使用：nuls123456
Please enter the password (password is between 8 and 20 inclusive of numbers and letters), If you do not want to set a password, return directly.
Enter your password:**********  #设置导入地址的密码，此密码与第4步第3条记录的密码必须一致
Please confirm new password:********** #重复上一步输入的密码
tNULSeBaMnrs6JKrCy6TQdzYJZkMZJDng7QAsD #导入地址成功，验证此地址是否与第4步第2条的配置项完全一致
```

### 8 使用短视保业务功能

- 准备2个账户，用于作为，下方两个地址是测试环境创世块中定义的地址，账户中有一定数量的资产供测试使用。密码默认使用：nuls123456  

  ```
  nuls>>> import 477059f40708313626cccd26f276646e4466032cabceccbf571a7c46f954eb75
  Please enter the password (password is between 8 and 20 inclusive of numbers and letters), If you do not want to set a password, return directly.
  Enter your password:**********
  Please confirm new password:**********
  tNULSeBaMnrs6JKrCy6TQdzYJZkMZJDng7QAsD
  
  nuls>>> import 8b0485b2b3f585156c7bf3e51e4b9fb53588f35b951b011cf60971e3aef4c412
  Please enter the password (password is between 8 and 20 inclusive of numbers and letters), If you do not want to set a password, return directly.
  Enter your password:**********
  Please confirm new password:**********
  tNULSeBaMncQWjkbsGzYb3rNjxRC6t7Pm7WKBF
  ```