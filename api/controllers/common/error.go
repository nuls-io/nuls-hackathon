package common

import (
	"github.com/astaxie/beego"
)

type Error struct {
	beego.Controller
}
//定义资源结构
type DataResponses struct {
	Code        int         `json:"code"`
	Msg        string      `json:"msg"`
	Data       interface{} `json:"data"`
}
type DataRequests struct {
	Data 	string
}
//定义接口返回信息
func (this *Error) JsonResults(Code int,Msg string,Data interface{},){
	r := DataResponses{Code,Msg,Data}
	this.Data["json"] = r
	this.ServeJSON()
	this.StopRun()
}
//定义401错误(请求要求用户的身份认证)
func (this *Error) Error401() {
	this.JsonResults(0,"Unauthorized","401")
}
//定义403错误(服务器理解请求客户端的请求，但是拒绝执行此请求)
func (this *Error) Error403() {
	this.JsonResults(0,"Forbidden","403")
}
//定义404错误
func (this *Error) Error404() {
	this.JsonResults(0,"No interface found","404")
}
//定义500错误(服务器内部错误，无法完成请求)
func (this *Error) Error500() {
	this.JsonResults(0,"Internal Server Error","500")
}
//定义501错误(服务器不支持请求的功能，无法完成请求)
func (this *Error) Error501() {
	this.JsonResults(0,"Not Implemented","501")
}
//定义503错误(由于超载或系统维护，服务器暂时的无法处理客户端的请求。延时的长度可包含在服务器的Retry-After头信息中)
func (this *Error) Error503() {
	this.JsonResults(0,"Service Unavailable","503")
}
//定义数据库关闭
func (this *Error) ErrorDb() {
	this.JsonResults(0,"database is now down","")
}


