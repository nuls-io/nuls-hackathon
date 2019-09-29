/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-15 16:11:29
 * @LastEditTime: 2019-08-18 21:59:15
 * @LastEditors: Please set LastEditors
 */
package pc

import (
	"time"
	"strconv"
	"github.com/ShortVideo/api/models"
	"encoding/json"
	"github.com/ShortVideo/api/utils"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego"
)

type Login struct {
	Base
}
//执行PC端注册用户的操作
func (this *Login) Register(){
	if this.Ctx.Request.Method == "POST" {
		user_reg := models.ReqRegister{}
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &user_reg); err == nil {
			user :=  models.User{}
			userMod :=  models.User{}
			userblock :=  models.UserBlock{}
			userlog :=  models.UserLog{}
			//用户去重处理
			orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Mobile",user_reg.Mobile).One(&user)
			if user_reg.Mobile == ""{
				this.JsonResult(0,"请输入手机号","")
			}else if (utils.VerifyMobileFormat(user_reg.Mobile) != true) {
				this.JsonResult(0,"手机号格式错误","")
			}else if (user.Id != 0 || user.Mobile == user_reg.Mobile){
				this.JsonResult(0,"该用户已注册","")
			}else if user_reg.Password == ""{
				this.JsonResult(0,"请输入密码","")
			}else if utils.VerifyPasswordFormat(user_reg.Password) != true {
				this.JsonResult(0,"密码格式为8~20位数字加字母组合","")
			}else if user_reg.Repassword == ""{
				this.JsonResult(0,"请再次输入密码","")
			}else if utils.VerifyPasswordFormat(user_reg.Repassword) != true {
				this.JsonResult(0,"再次输入密码格式为8~20位数字加字母组合","")
			}else if ( user_reg.Password != user_reg.Repassword ){
				this.JsonResult(0,"两次密码输入不一致","")
			}
			userMod.Mobile    		= user_reg.Mobile
			userMod.NickName    	= user_reg.Mobile[:3] + "****" + user_reg.Mobile[7:]
			userMod.Types    		= 0
			userMod.Status    		= 1
			userMod.RegisterIp 		= this.Ctx.Input.IP()
			userMod.Salt    		= utils.GenValidateCode(6)
			userMod.Password    	= utils.Md5(userMod.Salt + user_reg.Password)
			userMod.CreateTime    	= time.Now().Unix()
			var images string
			if len(images) > 35{
				images 					= "static/resource/images/user/001.png"
			}else{
				images 					= utils.FileOne("static/resource/images/user/")
			}
			userMod.Avatar    		= images
			o := orm.NewOrm()
			//开启事务
			err = o.Begin()
			id, err := o.Insert(&userMod)
			//区块表
			userblock.UserId			= id
			userblock.Username			= userMod.Mobile
			userblock.Usertype			= 0
			userblock.RegPlatform		= beego.AppConfig.String("blockregplatform")
			userblock.RegTime			= userMod.CreateTime
			userblock.CreateTime		= time.Now().Unix()
			userblock.Status			= 2
			_,ublock := o.Insert(&userblock)
			//入日志表
			userlog.UserId  			= id
			userlog.UserType  			= userMod.Types
			userlog.Types  				= 1
			userlog.LoginIp  			= userMod.RegisterIp
			userlog.Content  			= "用户注册"
			userlog.Result  			= "成功"
			userlog.CreateTime  		= time.Now().Unix()
			userlog.Status  			= 1
			userlog.Optime  			= userMod.CreateTime
			_,userlogdb := o.Insert(&userlog)
			if (err != nil || ublock != nil || userlogdb != nil){
				o.Rollback()
				this.JsonResult(0,"注册失败","")
			}else{
				o.Commit()
				this.JsonResult(1,"注册成功","")
			}
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//执行PC端用户登录(个人,企业)的操作
func (this *Login) Login(){
	if this.Ctx.Request.Method == "POST" {
		alogin := models.ReqLogin{}
		user := models.User{}
		login := models.ResLogin{}
		userlog :=  models.UserLog{}
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &alogin); err == nil {
			orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Mobile",alogin.Mobile).One(&user)
			if alogin.Mobile == ""{
				this.JsonResult(0,"请输入手机号","")
			}else if (utils.VerifyMobileFormat(alogin.Mobile) != true) {
				this.JsonResult(0,"手机号格式错误","")
			}
			if alogin.Password == ""{
				this.JsonResult(0,"请输入密码","")
			}else if utils.VerifyPasswordFormat(alogin.Password) != true {
				this.JsonResult(0,"密码格式错误","")
			}else if user.Id == 0 {
				this.JsonResult(0,"用户不存在","")
			}else if utils.Md5(user.Salt + alogin.Password) != user.Password{
				this.JsonResult(0,"登录密码错误","")
			}else if user.Status != 1{
				this.JsonResult(0,"该用户已冻结","")
			}else{
				login.Id = user.Id
				login.Username 	= user.NickName
				login.Types 	= user.Types
				login.Mobile   = user.Mobile[:3] + "****" + user.Mobile[7:]
				//token验证操作
				var user_id  = strconv.Itoa(login.Id)
				var apitoken  =  utils.Sha1(user_id+utils.GenValidateCode(6))
				jwtthltime,_:=  strconv.ParseInt(beego.AppConfig.String("jwtthl"),10,64)
				token :=  utils.GenToken(user_id, apitoken, apitoken, jwtthltime)
				if token == "" || err != nil {
					this.JsonResult(1,"生产token异常，请稍后重试","")
				} else {
					o := orm.NewOrm()
					//开启事务
					err := o.Begin()
					login.Token   = token
					//token入库
					user.ApiToken = apitoken
					// user.Update()
					_,userdb := o.Update(&user)
					//填写登录日志
					userlogin :=  models.UserLogin{}
					userlogin.UserId = login.Id
					userlogin.LoginIp = this.Ctx.Input.IP()
					userlogin.CreateTime = time.Now().Unix()
					_,userlogindb := o.Insert(&userlogin)
					//入日志表
					userlog.UserId,_ 			= strconv.ParseInt(user_id, 10, 64)
					userlog.UserType  			= user.Types
					userlog.Types  				= 0
					userlog.LoginIp  			= userlogin.LoginIp
					userlog.Content  			= "用户登录"
					userlog.Result  			= "成功"
					userlog.CreateTime  		= time.Now().Unix()
					userlog.Status  			= 1
					userlog.Optime  			= userlogin.CreateTime
					_,userlogdb := o.Insert(&userlog)
					if (err != nil || userdb != nil || userlogindb != nil || userlogdb != nil){
						o.Rollback()
						this.JsonResult(0,"登录失败","")
					}else{
						o.Commit()
						this.JsonResult(1,"登录成功",login)
					}
				}
			}
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}









