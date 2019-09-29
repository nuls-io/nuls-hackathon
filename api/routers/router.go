/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-19 18:38:06
 * @LastEditTime: 2019-08-31 16:40:25
 * @LastEditors: Please set LastEditors
 */
// @APIVersion 1.0.0
// @Title beego Test API
// @Description beego has a very cool tools to autogenerate documents for your API
// @Contact astaxie@gmail.com
// @TermsOfServiceUrl http://beego.me/
// @License Apache 2.0
// @LicenseUrl http://www.apache.org/licenses/LICENSE-2.0.html
package routers

import (
	"github.com/ShortVideo/api/controllers/common"
	"github.com/ShortVideo/api/controllers/pc"
	"github.com/ShortVideo/api/controllers/mobile"
	"github.com/astaxie/beego"
)
func init() {
	beego.Router("/", &pc.Base{}, "*:HelloApi")
	ns := beego.NewNamespace("/v1",
		//首页信息的操作
		beego.NSNamespace("/Index",
			beego.NSRouter("/", &mobile.Base{}, "*:HelloApi"),//首页API信息
			beego.NSRouter("/Works", &pc.Works{}, "post:Indexs"),//首页提示信息
			beego.NSRouter("/HotBroadcast", &pc.Works{}, "post:Hot"),//热播视频
			beego.NSRouter("/Credentials", &pc.Works{}, "post:Certificate"),//执行查看版权证书的操作
			beego.NSRouter("/WorksDetails", &pc.Works{}, "post:Details"),//获取证书详情的操作
			beego.NSRouter("/WorksLike", &pc.Works{}, "post:Like"),//获取作品喜欢的操作
		),
		//blocks控制器的操作
		beego.NSNamespace("/Blocks",
			beego.NSRouter("/Register", &mobile.Blocks{}, "*:RegisterUser"),//版权用户存证
			beego.NSRouter("/Works", &mobile.Blocks{}, "*:RegisterWorks"),//版权作品存证
		),
		beego.NSNamespace("/pc",
			//首页信息
			beego.NSNamespace("/Index",
				beego.NSRouter("/", &pc.Base{}, "*:HelloApi"),//首页API信息
			),
			//login控制器
			beego.NSNamespace("/Login",
				beego.NSRouter("/Register", &pc.Login{}, "post:Register"),//用户注册
				beego.NSRouter("/Login", &pc.Login{}, "post:Login"),//用户登录
			),
			//user控制器
			beego.NSNamespace("/User",
				beego.NSRouter("/SignOut", &pc.User{}, "post:LoginOut"),//用户退出
			),
			//Works控制器
			beego.NSNamespace("/Copyright",
				beego.NSRouter("/Index", &pc.Works{}, "post:Index"),//执行获取作品列表
				beego.NSRouter("/Proof", &pc.Works{}, "post:CopyRight"),//执行版权存证的操作
				beego.NSRouter("/Upload", &pc.Works{}, "post:Uploads"),//执行版权存证上传文件的操作(单文件,多文件)
				beego.NSRouter("/Credentials", &pc.Works{}, "post:Certificate"),//执行查看版权证书的操作
				beego.NSRouter("/Credentialss", &pc.Works{}, "*:Certificates"),//执行查看版权证书的操作,不限制传递方式
			),
		),
	)
	beego.AddNamespace(ns)
	beego.ErrorController(&common.Error{})
}
