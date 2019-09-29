/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-06-06 18:03:51
 * @LastEditTime: 2019-08-17 16:07:54
 * @LastEditors: Please set LastEditors
 */
package main

import (
	_ "github.com/ShortVideo/api/routers"

	"github.com/astaxie/beego"
)

func main() {
	if beego.BConfig.RunMode == "dev" {
		beego.BConfig.WebConfig.DirectoryIndex = true
		beego.BConfig.WebConfig.StaticDir["/swagger"] = "swagger"
	}
	beego.Run()
}
