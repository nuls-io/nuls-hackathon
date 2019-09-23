<!--
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-08-19 13:57:21
 * @LastEditTime: 2019-09-08 13:53:34
 * @LastEditors: Please set LastEditors
 -->
> api接口信息

在本地go环境中运行，若是有些包没有，根据错误提示进行安装依赖包(重要)
运行命令：bee run
配置信息调整在conf文件夹中

db_videos.sql是不包含数据的文件
db_videos_data.sql是包含数据的文件

api.json是使用postman测试的json文件
api.sh是shell脚本(linux中运行)，监控进程是否关闭，若是关闭进行启动，需要定时任务，在不同的服务器中不同的go运行环境需要进行配置

在linux中运行go程序
使用go build编译下程序
然后在后台运行进行，命令为:nohup ./编译的进行名   &


扩展和公共函数文件放在utils文件夹中

请求接口和相应接口文件在models文件中，分别为reques.go,response.go

[Beego开发文档](https://beego.me/docs/intro/)
[Go中文库文档](https://studygolang.com/pkgdoc)
[Golang 在 Mac、Linux、Windows 下如何交叉编译](https://studygolang.com/articles/12973?fr=sideba)