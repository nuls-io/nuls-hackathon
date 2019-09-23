/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-29 13:44:45
 * @LastEditTime: 2019-08-18 15:46:16
 * @LastEditors: Please set LastEditors
 */
package pc

import (
	"time"
	"strconv"
	"github.com/ShortVideo/api/models"
	"github.com/astaxie/beego/orm"
)

type User struct {
	Base
}
//用户退出的操作
func (this *User) LoginOut(){
	if this.Ctx.Request.Method == "POST" {
		user 	:= models.User{}
		userlog := models.UserLog{}
		user_id  := this.ApiAuth()
		orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",user_id).One(&user)
		if (user.Id == 0 || user.Id !=  user_id){
			this.JsonResult(0,"用户不存在","")
		}else{
			//更新数据
			user.ApiToken    	= ""
			//日志数据
			userlog.UserId,_ 			= strconv.ParseInt(strconv.Itoa(user.Id), 10, 64)
			userlog.UserType  			= user.Types
			userlog.Types  				= 4
			userlog.LoginIp  			= this.Ctx.Input.IP()
			userlog.Content  			= "用户退出"
			userlog.Result  			= "成功"
			userlog.CreateTime  		= time.Now().Unix()
			userlog.Status  			= 1
			userlog.Optime  			= time.Now().Unix()
			o := orm.NewOrm()
			//开启事务
			err := o.Begin()
			//入库
			_,userdb := o.Update(&user)
			_,userlogdb := o.Insert(&userlog)
			if (err != nil || userdb != nil ||  userlogdb != nil){
				o.Rollback()
				this.JsonResult(0,"退出失败","")
			}else{
				o.Commit()
				this.JsonResult(1,"退出成功","")
			}
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}








