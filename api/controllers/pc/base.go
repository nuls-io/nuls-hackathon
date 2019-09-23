/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-22 14:16:47
 * @LastEditTime: 2019-08-30 17:54:48
 * @LastEditors: Please set LastEditors
 */
package pc

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
	"os"
	qrcode "github.com/skip2/go-qrcode"
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
//定义一个Data空结构
type Empty struct {
	
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
	//单文件上传处理
	f, h, err := this.GetFile(filename)
	if h == nil {
		this.JsonResult(0,"请选择文件","")
	}
	out := make(map[string]interface{})
	if err != nil {
		out["msg"] = "文件读取错误"
	}
	var fileSuffix, newFile string
	fileSuffix = strings.ToLower(path.Ext(h.Filename)) //获取文件后缀
	//验证后缀名是否符合要求
	var AllowExtMap map[string]bool 
	//验证视频格式
	if intTypes == 17 {
		//视频
		var file_Suffix map[string]bool = map[string]bool{
			".mp4":true,
			".MP4":true,
			".mov":true,
			".MOV":true,
			".rmvb":true,
			".RMVB":true,
			".3gpp":true,
			".3GPP":true,
			".mpeg":true,
			".MPEG":true,
			".mpg":true,
			".MPG":true,
			".3gp":true,
			".3GP":true,
			".wmv":true,
			".WMV":true,
			".asf":true,
			".ASF":true,
			".asx":true,
			".ASX":true,
			".rm":true,
			".RM":true,
			".m4v":true,
			".M4V":true,
			".avi":true,
			".AVI":true,
			".dat":true,
			".DAT":true,
			".mkv":true,
			".MKV":true,
			".flv":true,
			".FLV":true,
			".vob":true,
			".VOB":true,
		}
		AllowExtMap = file_Suffix
	}else if intTypes == 43  {
		////图片-验证视频封面格式
		var file_Suffix map[string]bool = map[string]bool{
			".jpg":true,
			".JPG":true,
			".png":true,
			".PNG":true,
			".jpeg":true,
			".JPEG":true,
		}
		AllowExtMap = file_Suffix
	}
	if _,ok:=AllowExtMap[fileSuffix];!ok{
		this.JsonResult(0,"后缀名不符合上传要求","")
		return 
	}
	//验证文件的大小是否符合要求
	if h.Size > 157286400 {
		this.JsonResult(0,"文件不能超过150MB","")
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
	}else{
		works_file.Types			 = 0
	}
	works_file.CreateTime	     = time.Now().Unix()
	works_file.FileData			 = filepath + newFile
	works_file.Status			 = 0
	works_file.Sizes			 = strconv.FormatInt(h.Size,10)
	works_file.Hash,_			 = utils.SHA256File(works_file.FileData)
	id, err := orm.NewOrm().Insert(&works_file)
	//查询
	works_files := []*models.WorksFiles{}
	orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("UserId",user).Filter("Id",id).All(&works_files)
	list := make([]map[string]interface{}, len(works_files))
	for kk,_:= range works_files {
		row := make(map[string]interface{})
		row["url"] 					 = works_file.FileData
		row["file_id"] 				 = id
		row["file_name"] 			 = newFile
		row["state"] 				 = "SUCCESS"
		row["msg"] 					 = "ok"
		list[kk] = row
	}
	if err != nil {
		this.JsonResult(0,"上传失败","")
	}else{
		this.JsonResult(1,"恭喜您,上传成功!",list)
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
func  (this *Base) ImageWordPC(WorksId,Name,Obligee,Types,AuthorName,pubSize,BlcokID,BlcokTime string,Works_id int) string{
    const S = 1702
	const W = 2269
	var images string
    im, err := gg.LoadImage("static/resource/images/05.png")
    if err != nil {
		// log.Fatal(err)
		images  = "static/resource/images/05.png"
	}
    dc := gg.NewContext(S, W)
    if err := dc.LoadFontFace("static/resource/fonts/ArialBold.ttf", 30); err != nil {
		// panic(err)
		images  = "static/resource/images/05.png"
    }
    dc.DrawRoundedRectangle(0, 0, 200, 200, 0)
    //
	dc.DrawImage(im, 0, 0)
	//证书ID
    dc.SetHexColor("#BB9C65")
    dc.DrawStringWrapped(WorksId, S/4.8, W/3.75, 0.5, 0.5,0,0,0)
    if err := dc.LoadFontFace("static/resource/fonts/ArialUnicode.ttf", 35); err != nil {
        panic(err)
    }
	dc.SetHexColor("#030303")
	var Obligee_new,Name_new,AuthorNam_new string
	// 去除空格
	Obligee = strings.Replace(Obligee, " ", "", -1)
	Obligee = strings.Replace(Obligee, "  ", "", -1)
	// 去除换行符
	Obligee = strings.Replace(Obligee, "\n", "", -1)
	Obligee = strings.Replace(Obligee, "\r", "", -1)
	res_Obligee := []rune(Obligee)
    if (len(res_Obligee) >= 0 && len(res_Obligee) <= 20){
       	//权利人
    	dc.DrawStringWrapped(Obligee, S/2.25, W/3.11, 0.5, 0.5,0,0,0)
    }else{
        Obligee_new  = utils.SubString(Obligee,0,20)+"\n"+utils.SubString(Obligee,21,19)
		//权利人
		dc.DrawStringWrapped(Obligee_new, S/2.25, W/3.03, 0.5, 0.5,0,1.7,0)
	}
	// 去除空格
	Name = strings.Replace(Name, " ", "", -1)
	Name = strings.Replace(Name, "  ", "", -1)
	// 去除换行符
	Name = strings.Replace(Name, "\n", "", -1)
	Name = strings.Replace(Name, "\r", "", -1)
	res_Name := []rune(Name)
	if (len(res_Name) >= 0 && len(res_Name) <= 20){
		//作品名称
		dc.DrawStringWrapped(Name, S/2.25, W/2.75, 0.5, 0.5,0,0,0)
	}else{
		Name_new  = utils.SubString(Name,0,20)+"\n"+utils.SubString(Name,21,19)
		//作品名称
		dc.DrawStringWrapped(Name_new, S/2.25, W/2.69, 0.5, 0.5,0,1.7,0)
	}
    //作品类型
	dc.DrawStringWrapped(Types, S/2.25, W/2.48, 0.5, 0.5,0,0,0)
	// 去除空格
	AuthorName = strings.Replace(AuthorName, " ", "", -1)
	AuthorName = strings.Replace(AuthorName, "  ", "", -1)
	// 去除换行符
	AuthorName = strings.Replace(AuthorName, "\n", "", -1)
	AuthorName = strings.Replace(AuthorName, "\r", "", -1)
	res_AuthorName := []rune(AuthorName)
	if (len(res_AuthorName) >= 0 && len(res_AuthorName) <= 20){
		//作者名称
		dc.DrawStringWrapped(AuthorName, S/2.25, W/2.25, 0.5, 0.5,0,0,0)
	}else{
		AuthorNam_new  = utils.SubString(AuthorName,0,19)
		//作者名称
		dc.DrawStringWrapped(AuthorNam_new, S/2.25, W/2.25, 0.5, 0.5,0,0,0)
	}
	//存证平台
	var platform string
	if beego.AppConfig.String("copyrightplatform") == ""{
		platform = "杭州下笔有神科技有限公司"
	}else{
		platform = beego.AppConfig.String("copyrightplatform")
	}
	dc.DrawStringWrapped(platform, S/2.25, W/2.06, 0.5, 0.5,0,0,0)
	//文件大小
	dc.DrawStringWrapped(pubSize+"(字节)", S/2.25, W/1.9, 0.5, 0.5,0,0,0)
	//存证时间
	dc.DrawStringAnchored(BlcokTime, S/1.87, W/1.76, 0.5, 0.5)
	if err := dc.LoadFontFace("static/resource/fonts/SimSun.ttf", 35); err != nil {
        panic(err)
    }
    //区块链Hash
	dc.DrawStringWrapped(BlcokID, S/5.6, W/1.34, 0.5, 0.5,0,0,0)
	//执行存证Hash水印
	var qrcode_image,httpurl  string
	qrcode_image = "static/resource/copyright/qrcode/qrcode.png"
	if beego.AppConfig.String("runmode") == "prod"{
		httpurl = beego.AppConfig.String("copyrighturlqrcodedev")
	}else{
		httpurl = beego.AppConfig.String("copyrighturlqrcodemain")
	}
	qrcode := qrcode.WriteFile(httpurl+strconv.Itoa(Works_id), qrcode.Medium, 180, qrcode_image)
    if qrcode != nil {
		qrcode_image = "static/resource/images/01.png"
	}
    ims, err := gg.LoadImage(qrcode_image)
    dc.DrawImage(ims, 772, 1420)
	dc.Clip()
	//创建路径地址
	filepath := "static/resource/copyright/pc/" + beego.Date(time.Now(), "Ymd") + "/"
	err = os.MkdirAll(filepath, 0777)
	if err != nil {
		images  = "static/resource/images/05.png"
	}else{
		newFile := utils.GetRandomString(8) + ".png"
		images  = filepath+newFile
	}
    dc.SavePNG(images)
    return images
}