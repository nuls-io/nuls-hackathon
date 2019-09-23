### 
# @Description: In User Settings Edit
 # @Author: your name
 # @Date: 2019-06-06 18:03:51
 # @LastEditTime: 2019-08-17 16:26:31
 # @LastEditors: Please set LastEditors
 ###
#!/bin/bash

ps -ef | grep api | grep -v grep
if [ $? -ne 0 ]
then
echo "--------Startup process--------"
nohup  /root/golib/src/github.com/api/api &
else
echo "--------The process is running-------"
fi