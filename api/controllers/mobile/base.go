/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-22 14:16:47
 * @LastEditTime: 2019-08-25 22:55:40
 * @LastEditors: Please set LastEditors
 */
package mobile

import (
	"github.com/astaxie/beego"
	// "encoding/json"
	"strconv"
	"time"
	"path"
	"strings"
	"github.com/ShortVideo/api/utils"
	"github.com/astaxie/beego/orm"
	"github.com/ShortVideo/api/models"
	"github.com/fogleman/gg"
	// "log"
	"os"
)

type Base struct {
	beego.Controller
}
//定义资源结构
type DataResponse struct {
	Code        int         `json:"code"`
	Msg        string      `json:"msg"`
	Data       interface{} `json:"data"`
}
type DataRequest struct {
	Data 	string
}
//定义接口返回信息
func (this *Base) JsonResult(Code int,Msg string,Data interface{},){
	r := DataResponse{Code,Msg,Data}
	this.Data["json"] = r
	this.ServeJSON()
	this.StopRun()
}
//执行入口访问api信息
func (this *Base) HelloApi() {
	this.JsonResult(1,"Hello, ResultFul API","")
}
//执行验证token是否可以正常登陆的操作
func (this *Base) ApiAuth()  int {
	user :=  models.User{}
	jwt := strings.TrimSpace(this.Ctx.Request.Header.Get("Authorization"))
	//未授权访问
	if jwt == "" {
		this.JsonResult(2,"请重新登录","")
	}
	check_token := utils.CheckToken(jwt)
	if check_token != true {
		this.JsonResult(2,"请重新登录","")
	}
	jclaim, err := utils.ParseJwt(jwt)
		//未授权访问
	if jclaim == nil {
		this.JsonResult(2,"请重新登录","")
	}
	orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",jclaim.UserId).One(&user)
	//登录已过期
	if user.Id == 0 {
		this.JsonResult(2,"请重新登录","")
	}
	if user.ApiToken != jclaim.OrgUnitId {
		this.JsonResult(2,"请重新登录","")
	}
	if err != nil {
		this.JsonResult(2,"请重新登录","")
	}
	return  user.Id
}
//定义上传文件
func (this *Base) UploadFile(filename string, filepath string,intTypes int,user int) {
	f, h, err := this.GetFile(filename)
	if h == nil {
		this.JsonResult(0,"请选择文件","")
	}
	out := make(map[string]interface{})
	if err != nil {
		out["msg"] = "文件读取错误"
	}
	var fileSuffix, newFile string
	fileSuffix = path.Ext(h.Filename) //获取文件后缀
	//验证后缀名是否符合要求
	var AllowExtMap map[string]bool 
	if intTypes == 17 {
		//视频
		var file_Suffix map[string]bool = map[string]bool{
			".mp4":true,
			".mov":true,
			".rmvb":true,
		}
		AllowExtMap = file_Suffix
	}else if intTypes == 23  {
		//音频
		var file_Suffix map[string]bool = map[string]bool{
			".mp3":true,
			".wma":true,
			".arm":true,
		}
		AllowExtMap = file_Suffix
	}else if intTypes == 35  {
		//文本文件
		var file_Suffix map[string]bool = map[string]bool{
			".txt":true,
			".doc":true,
			".docx":true,
			".ppt":true,
		}
		AllowExtMap = file_Suffix
	}else if intTypes == 43  {
		//图片
		var file_Suffix map[string]bool = map[string]bool{
			".jpg":true,
			".png":true,
			".jpeg":true,
		}
		AllowExtMap = file_Suffix
	}else{
		var file_Suffix map[string]bool = map[string]bool{
			".mp4":true,
			".mov":true,
			".rmvb":true,
			".txt":true,
			".doc":true,
			".docx":true,
			".ppt":true,
			".mp3":true,
			".wma":true,
			".arm":true,
			".jpg":true,
			".png":true,
			".jpeg":true,
		}
		AllowExtMap = file_Suffix
	}

	if _,ok:=AllowExtMap[fileSuffix];!ok{
		this.JsonResult(0,"后缀名不符合上传要求","")
		return 
	}
	//验证文件的大小是否符合要求
	if h.Size > 52428800 {
		this.JsonResult(0,"文件不能超过50MB","")
		return
	}
	newFile = utils.GetRandomString(8) + fileSuffix
	err = this.SaveToFile("upfile", filepath+newFile)
	if err != nil {
		out["msg"] = "文件保存错误"
	}
	defer f.Close()
	out["state"] = "SUCCESS"
	out["url"] = filepath + newFile
	out["msg"] = "ok"
	//入库
	works_file := models.WorksFiles{}
	works_file.UserId			 = user
	if intTypes == 17 {
		works_file.Types			 = 1
	}else if intTypes == 23 {
		works_file.Types			 = 2
	}else if intTypes == 35 {
		works_file.Types			 = 4
	}else if intTypes == 43 {
		works_file.Types			 = 3
	}else{
		works_file.Types			 = 0
	}
	works_file.CreateTime	     = time.Now().Unix()
	works_file.FileData			 = filepath + newFile
	works_file.Status			 = 0
	works_file.Sizes			 = strconv.FormatInt(h.Size,10)
	works_file.Hash,_			 = utils.SHA256File(works_file.FileData)
	id, err := orm.NewOrm().Insert(&works_file)
	out["file_id"] = id
	this.Data["json"] = out
	if err != nil {
		this.JsonResult(0,"上传失败","")
	}else{
		this.JsonResult(1,"恭喜您,上传成功!",out)
	}
}
//文本水印信息
//执行封装图片加上文字水印操作
func  (this *Base) ImageWord(WorksId,Name,Obligee,Types,CtreateTime,Right,Range,BlcokID,BlcokTime string) string{
    const S = 1673
	const W = 1246
	var images string
    im, err := gg.LoadImage("static/resource/images/03.jpg")
    if err != nil {
		// log.Fatal(err)
		images  = "static/resource/images/03.jpg"
	}
    dc := gg.NewContext(S, W)
    dc.SetRGB(0, 0, 0)
    dc.Clear()
    dc.SetRGB(0, 0, 0)
    if err := dc.LoadFontFace("static/resource/fonts/SimSun.ttf", 20); err != nil {
		// panic(err)
		images  = "static/resource/images/03.jpg"
    }
    dc.DrawRoundedRectangle(0, 0, 200, 200, 0)
    //
	dc.DrawImage(im, 0, 0)
    // //证书ID
    dc.DrawStringWrapped(WorksId, S/2.8, W/3.8, 0.5, 0.5,0,0,0)
    //作品名称
    dc.DrawStringWrapped(Name, S/4.1, W/2.8, 0.5, 0.5,0,0,0)
    //权利人
    dc.DrawStringWrapped(Obligee, S/4, W/2.37, 0.5, 0.5,0,0,0)
    //作品类型
    dc.DrawStringWrapped(Types, S/4.1, W/2.05, 0.5, 0.5,0,0,0)
    //创作时间
    dc.DrawStringAnchored(CtreateTime, S/3.3, W/1.82, 0.5, 0.5)
    //权利类型
    dc.DrawStringAnchored(Right, S/1.68, W/2.37, 0.5, 0.5)
    //权利范围
    dc.DrawStringWrapped(Range, S/1.72, W/2.05, 0.5, 0.5,0,0,0)
    //区块链存证ID
    dc.DrawStringAnchored(BlcokID, S/2.33, W/1.28, 0.5, 0.5)
    //区块链存证时间
    dc.DrawStringAnchored(BlcokTime, S/2.85, W/1.24, 0.5, 0.5)
	dc.Clip()
	//创建路径地址
	filepath := "static/resource/copyright/" + beego.Date(time.Now(), "Ymd") + "/"
	err = os.MkdirAll(filepath, 0777)
	if err != nil {
		images  = "static/resource/images/03.jpg"
	}else{
		newFile := utils.GetRandomString(8) + ".png"
		images  = filepath+newFile
	}
    dc.SavePNG(images)
    return images
}
//执行封装图片加上文字水印的效果(PC端)
func  (this *Base) ImageWordPC(WorksId,Name,BlcokTime,Cover string) string{
    const S = 1125
	const W = 1890
	var images string
    im, err := gg.LoadImage("static/resource/images/007.png")
    if err != nil {
		images  = "static/resource/images/007.png"
	}
    dc := gg.NewContext(S, W)
    if err := dc.LoadFontFace("static/resource/fonts/ArialBold.ttf", 25); err != nil {
		images  = "static/resource/images/007.png"
    }
    dc.DrawRoundedRectangle(0, 0, 200, 200, 0)
    //
	dc.DrawImage(im, 0, 0)
	//证书ID
    dc.SetHexColor("#BB9C65")
    dc.DrawStringWrapped(WorksId, S/9, W/4.1, 0.5, 0.5,0,0,0)
    if err := dc.LoadFontFace("static/resource/fonts/ArialUnicode.ttf", 35); err != nil {
        panic(err)
    }
	//存证平台
	platform :=  "短视保账户 "+Name+" 作品"
    platform = strings.Replace(platform, " ", "", -1)
	platform = strings.Replace(platform, "  ", "", -1)
	// 去除换行符
	platform = strings.Replace(platform, "\n", "", -1)
	platform = strings.Replace(platform, "\r", "", -1)
	dc.DrawStringWrapped(platform, S/4.1, W/1.58, 0.5, 0.5,0,0,0)
	//存证时间
	times  := "已于 "+BlcokTime+" 完成区块链作品存证"
	dc.DrawStringAnchored(times, S/1.98, W/1.5, 0.5, 0.5)
	//存证说明
	dc.DrawStringWrapped("本存证证书通过文件加密算法，生成并锚定至NULS公链", S/9, W/1.3, 0.5, 0.5,0,0,0)
	dc.DrawStringWrapped("完成网络存证,当此作品是您的原创作品并产生版权确权和", S/9, W/1.25, 0.5, 0.5,0,0,0)
	dc.DrawStringWrapped("维权需求时,可以将此存证证书作为举证时的重要证据之一。", S/9, W/1.2, 0.5, 0.5,0,0,0)
	//执行存证Hash水印
    ims, err := gg.LoadImage(Cover)
    dc.DrawImageAnchored(ims,-1,-1,-0.36,-0.8)
	dc.Clip()
	//创建路径地址
	filepath := "static/resource/copyright/pc/" + beego.Date(time.Now(), "Ymd") + "/"
	err = os.MkdirAll(filepath, 0777)
	if err != nil {
		images  = "static/resource/images/007.png"
	}else{
		newFile := utils.GetRandomString(8) + ".png"
		images  = filepath+newFile
	}
    dc.SavePNG(images)
    return images
}