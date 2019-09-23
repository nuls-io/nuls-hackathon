/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-23 09:32:21
 * @LastEditTime: 2019-08-31 16:49:12
 * @LastEditors: Please set LastEditors
 */
package pc

import (
	"time"
	// "fmt"
	"os"
	"unsafe"
	"strconv"
	"strings"
	// "math"
	"github.com/ShortVideo/api/models"
	"encoding/json"
	"github.com/ShortVideo/api/utils"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego"
)

type Works struct {
	Base
}
//执行获取存证列表的操作
func (this *Works) Index(){
	if this.Ctx.Request.Method == "POST" {
		user := models.User{}
		works := []*models.Works{}
		reqworks := models.ReqWorks{}
		resList	 :=	models.ResWorksList{}
		workscopyright 			:= models.WorksCopyright{}
		user_id  := this.ApiAuth()
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &reqworks); err == nil {
			orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",user_id).One(&user)
			if user.Id == 0 {
				this.JsonResult(0,"用户不存在","")
			}else if user.Id !=  user_id{
				this.JsonResult(0,"用户不存在","")
			}else if user.Status != 1{
				this.JsonResult(0,"该账户已冻结","")
			}else{
				worksfiles := models.WorksFiles{}
				query := orm.NewOrm().QueryTable(new(models.Works).TableName())
				//执行作品名称搜索
				if (reqworks.Name != "" || len(reqworks.Name) > 0){
					query = query.Filter("Name__icontains",reqworks.Name)
				}
				//执行文件类型搜索
				if (reqworks.Types != 0 && reqworks.Types != 10){
					query = query.Filter("Types",reqworks.Types)
				}else if reqworks.Types == 10 {
					query = query.Filter("Types",0)
				}
				//按照时间搜索
				if (reqworks.StartTime != 0 && reqworks.EndTime == 0) {
					query = query.Filter("CreateTime__gte",reqworks.StartTime)
				}else if (reqworks.EndTime != 0 && reqworks.StartTime == 0) {
					query = query.Filter("CreateTime__lte",reqworks.EndTime)
				}else if (reqworks.EndTime != 0 && reqworks.StartTime != 0) {
					query = query.Filter("CreateTime__gte",reqworks.StartTime).Filter("CreateTime__lte",reqworks.EndTime)
				}
				workscount,_ := query.Filter("UserId",user.Id).Count()
				//每页条数限制
				pageSize := reqworks.Length
				if pageSize <= 0{
					pageSize = 10
				}else{
					pageSize = reqworks.Length
				}
				//调整为当前偏移行数
				intpage := reqworks.Page
				if intpage <= 0 {
					intpage = 0
				}
				query.Filter("UserId",user.Id).OrderBy("-CreateTime").Offset(intpage).Limit(pageSize).All(&works)
				list := make([]map[string]interface{}, len(works))
				for k, v := range works {
					row := make(map[string]interface{})
					row["works_id"] 			= v.Id
					row["works_name"] 			= v.Name
					orm.NewOrm().QueryTable(new(models.WorksCopyright).TableName()).Filter("works_id",row["works_id"]).Filter("user_id",user.Id).One(&workscopyright)
					row["certificate_id"] 		= workscopyright.Txid
					row["works_types"] 			= v.Types
					row["works_status"] 		= v.Status
					row["works_time"] 			= v.CreateTime
					orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId",v.Id).Filter("UserId",v.UserId).OrderBy("-id").One(&worksfiles)
					row["works_files"]		 	= worksfiles.FileData
					list[k] = row
				}
				resList.Data   =  list
				resList.Counts =  workscount
				this.JsonResult(1,"获取存证列表信息成功!",resList)
			}
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//执行首页列表信息显示的操作
func (this *Works) Indexs(){
	if this.Ctx.Request.Method == "POST" {
		works := []*models.Works{}
		reqworks := models.ReqWorks{}
		resList	 :=	models.ResWorksList{}
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &reqworks); err == nil {
				worksfiles := models.WorksFiles{}
				query := orm.NewOrm().QueryTable(new(models.Works).TableName())
				workscount,_ := query.Count()
				//每页条数限制
				pageSize := reqworks.Length
				if pageSize <= 0{
					pageSize = 10
				}else{
					pageSize = reqworks.Length
				}
				//调整为当前偏移行数
				intpage := reqworks.Page
				if intpage <= 0 {
					intpage = 0
				}
				query.OrderBy("-CreateTime").Offset(intpage).Limit(pageSize).All(&works)
				list := make([]map[string]interface{}, len(works))
				for k, v := range works {
					row := make(map[string]interface{})
					row["works_id"] 			= v.Id
					row["works_name"] 			= v.Name
					row["works_author"] 		= v.AuthorName
					row["works_time"] 			= v.CreateTime
					row["works_certificatepc"] 	= v.WorksCertificatepc
					row["image_height"] 		= utils.GenerateRangeNum(150,300)
					orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId",v.Id).Filter("UserId",v.UserId).OrderBy("-id").One(&worksfiles)
					row["works_files"]		 	= worksfiles.FileData
					row["works_videos_image"]   = v.Cover
					row["works_click"]   		= v.Click
					row["works_status"] 		= v.Status
					list[k] = row
				}
				resList.Data   =  list
				resList.Counts =  workscount
				this.JsonResult(1,"获取列表信息成功!",resList)
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//获取热播视频
func (this *Works) Hot(){
	if this.Ctx.Request.Method == "POST" {
		works := []*models.Works{}
		resList	 :=	models.ResWorksList{}
		worksfiles := models.WorksFiles{}
		query := orm.NewOrm().QueryTable(new(models.Works).TableName())
		workscount,_ := query.Count()
		query.OrderBy("-Click").Limit(3).All(&works)
		list := make([]map[string]interface{}, len(works))
		for k, v := range works {
			row := make(map[string]interface{})
			row["works_id"] 			= v.Id
			row["works_name"] 			= v.Name
			row["works_author"] 		= v.AuthorName
			row["works_time"] 			= v.CreateTime
			row["works_certificatepc"] 	= v.WorksCertificatepc
			row["image_height"] 		= utils.GenerateRangeNum(150,300)
			orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId",v.Id).Filter("UserId",v.UserId).OrderBy("-id").One(&worksfiles)
			row["works_files"]		 	= worksfiles.FileData
			row["works_videos_image"]   = v.Cover
			row["works_click"]   		= v.Click
			row["works_status"] 		= v.Status
			list[k] = row
		}
		resList.Data   =  list
		resList.Counts =  workscount
		this.JsonResult(1,"获取热播信息成功!",resList)
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//执行存证的操作
func (this *Works) CopyRight(){
	if this.Ctx.Request.Method == "POST" {
		user := models.User{}
		works := models.Works{}
		reqproof := models.ReqProof{}
		userlog :=  models.UserLog{}
		user_id  := this.ApiAuth()
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &reqproof); err == nil {
			orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",user_id).One(&user)
			if user.Id == 0 {
				this.JsonResult(0,"用户不存在","")
			}else if user.Id !=  user_id{
				this.JsonResult(0,"用户不存在","")
			}else if user.Status != 1{
				this.JsonResult(0,"该账户已冻结","")
			}else if reqproof.Name == ""{
				this.JsonResult(0,"请输入作品名称","")
			}else if reqproof.AuthorName == ""{
				this.JsonResult(0,"请输入作者名称","")
			}else if reqproof.Types == ""{
				this.JsonResult(0,"请选择作品类型","")
			}else if (reqproof.Types != "17" && reqproof.Types != "23" && reqproof.Types != "35" && reqproof.Types != "43" && reqproof.Types != "0"){
				this.JsonResult(0,"作品类型参数有误","")
			}else if reqproof.PublishStatus == ""{
				this.JsonResult(0,"请输入权利人","")
			}else if reqproof.Cover == ""{
				this.JsonResult(0,"请上传视频封面","")
			}else if reqproof.FileId == ""{
				this.JsonResult(0,"请上传文件","")
			}else{
				works_copyright := models.WorksCopyright{}
				works_files := models.WorksFiles{}
				works_filesc := models.WorksFiles{}
				works_filesd :=[] models.WorksFiles{}
				File_length := len(reqproof.FileId)
				//文件归属操作
				strs := reqproof.FileId
				ids := make([]int, 0, len(strs))
				for _, str := range strings.Split(strs, ",") {
					if id, err := strconv.Atoi(str); err == nil {
						ids = append(ids, id)
					}
				}
				idc,_  := strconv.Atoi(reqproof.Cover)
				//验证视频封面
				orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("id", idc).Filter("UserId",user.Id).OrderBy("-id").One(&works_filesc)
				//验证文件
				orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("id__in", ids).Filter("UserId",user.Id).OrderBy("id").All(&works_filesd)
				if works_filesc.Id == 0{
					this.JsonResult(0,"请上传视频封面","")
				}else if File_length == 0{
					this.JsonResult(0,"请选择文件","")
				}else{
					var  pubHash string
					var	 Hash 	 string
					for _, v1 := range works_filesd {
						if v1.Id == 0{
							this.JsonResult(0,"请选择文件","")
						}else if (v1.Id != 0 && v1.Status == 1){
							this.JsonResult(0,"该文件已存证,请重新上传","")
						}
						if (len(works_filesd) > 0  && len(works_filesd) ==1){
							pubHash  = v1.Hash
						}else if len(works_filesd) > 1{
							pubHash = pubHash+v1.Hash+"-"
						}
					}
					if (len(works_filesd) > 0  && len(works_filesd) ==1){
						Hash = pubHash
					}else{
						Hash  = utils.GetSHA256HashCode([]byte(pubHash))
					}
					user_obligee := models.UserObligee{}
					//执行入库
					o := orm.NewOrm()
					//开启事务
					err = o.Begin()
					//添加权利人
					user_obligee.UserId         	= user.Id
					user_obligee.Realname       	= reqproof.PublishStatus
					user_obligee.CreateTime    	 	= time.Now().Unix()
					id_obj,user_obligeedb 		    := o.Insert(&user_obligee)
					id_objs :=	(*int)(unsafe.Pointer(&id_obj))
					//添加存证作品
					Types,_ 						:= strconv.Atoi(reqproof.Types)
					works.UserId  					= user.Id
					works.ObligeeId  				= *id_objs
					works.Name  					= reqproof.Name
					works.AuthorName  				= reqproof.AuthorName
					works.Types  					= 17
					works.CreateTime  				= time.Now().Unix()
					works.Status  					= 0
					works.Cover  					= works_filesc.FileData
					if  reqproof.Click == 0{
						works.Click 			    = utils.GenerateRangeNum(800,1000)
					}else{
						works.Click					= reqproof.Click
					}
					works.FileData  				= reqproof.FileId
					w_id,worksdb 					:= o.Insert(&works)
					//更新权利人
					user_obligee.WorksId         	= w_id
					_,userodb 					:= o.Update(&user_obligee)
					//更新文件归属
					works_files.UpdateTime 			= time.Now().Unix()
					works_files.WorksId  			=  w_id
					works_files.Status  			=  1
					works_files.CommonHash  		=  Hash
					query := o.QueryTable(new(models.WorksFiles).TableName())
					_,err := query.Filter("id__in", ids).Filter("UserId",user.Id).Update(orm.Params{
							"UpdateTime": works_files.UpdateTime,"WorksId":works_files.WorksId,"Status":works_files.Status,"CommonHash":works_files.CommonHash,
						})
					//入存证区块表
					works_copyright.UserId			=  user.Id
					works_copyright.WorksId			=  w_id
					works_copyright.Status			=  0
					works_copyright.WorkName		=  works.Name
					works_copyright.Catalog			=  Types
					works_copyright.CreateNature	=  0
					works_copyright.WorkCreateTime	=  works.CreateTime 
					works_copyright.WorkPublishTime	=  works.CreateTime 
					works_copyright.WorkApplyTime	=  works.CreateTime 
					works_copyright.CreateTime		=  time.Now().Unix()
					_,w_copyrightdb  				:= o.Insert(&works_copyright)
					//入日志表
					userlog.UserId,_  				= strconv.ParseInt(strconv.Itoa(user.Id), 10, 64)
					userlog.UserType  				= user.Types
					userlog.Types  					= 5
					userlog.LoginIp  				= this.Ctx.Input.IP()
					userlog.Content  		    	= "用户存证"
					userlog.Result  				= "成功"
					userlog.CreateTime  			= time.Now().Unix()
					userlog.Status  				= 1
					userlog.Optime  				= time.Now().Unix()
					_,userlogdb := o.Insert(&userlog)
					if (err != nil || user_obligeedb != nil || worksdb != nil || userodb != nil || w_copyrightdb != nil   || userlogdb != nil){
						o.Rollback()
						this.JsonResult(0,"存证提交失败","")
					}else{
						o.Commit()
						this.JsonResult(1,"恭喜您,存证提交成功,请等待区块更新!","")
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
//执行存证文件上传的操作
func (this *Works) Uploads(){
	if this.Ctx.Request.Method == "POST" {
		user := models.User{}
		user_id  := this.ApiAuth()
		types  := this.GetString("types")
		intTypes,_ := strconv.Atoi(types)
			orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",user_id).One(&user)
			if user.Id == 0 {
				this.JsonResult(0,"用户不存在","")
			}else if user.Id !=  user_id{
				this.JsonResult(0,"用户不存在","")
			}else if user.Status != 1{
				this.JsonResult(0,"该用户已冻结","")
			}else if types == ""{
				this.JsonResult(0,"上传参数有误","")
			}else{
				var paths string
				if intTypes == 17{
					file_path := "static/upload/videos/"
					paths = file_path
				}else if intTypes == 43{
					file_path := "static/upload/videos/images/"
					paths = file_path
				}else{
					file_path := "static/upload/"
					paths = file_path
				}
				filepath := paths + beego.Date(time.Now(), "Ymd") + "/"
				_, err := os.Stat(filepath)
				if err != nil {
					err := os.MkdirAll(filepath, 0777)
					if err != nil {
						this.JsonResult(0,"上传失败","")
					}
				}
				this.UploadFile("upfile", filepath,intTypes,user.Id)
				this.JsonResult(0,"文件上传","")
			}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//执行版权证书的操作
func (this *Works) Certificate(){
	if this.Ctx.Request.Method == "POST" {
		works := models.Works{}
		ReqCertificate := models.ReqCertificate{}
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &ReqCertificate); err == nil {
			intId,_ := strconv.Atoi(ReqCertificate.Id)
			orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",intId).Filter("Status",1).OrderBy("-id").One(&works)
			if (ReqCertificate.Id == "" || works.Id == 0){
				this.JsonResult(0,"无效的存证ID","")
			}else{
				works_copyright := models.WorksCopyright{}
				works_files := models.WorksFiles{}
				orm.NewOrm().QueryTable(new(models.WorksCopyright).TableName()).Filter("WorksId",works.Id).Filter("Status",1).OrderBy("-id").One(&works_copyright)
				orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId",works.Id).Filter("Status",1).OrderBy("-id").One(&works_files)
				ResCopyright := models.ResCopyrightPC{}
				ResCopyright.Id     		=  works.Id
				ResCopyright.Hash     		=  works_files.CommonHash 
				ResCopyright.BlockHash    	=  works_copyright.Txid
				ResCopyright.Files     		=  works.WorksCertificatepc
				this.JsonResult(1,"获取证书信息成功",ResCopyright)
			}
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//执行查看证书的操作,不带任何操作
func (this *Works) Certificates(){
	works := models.Works{}
	works_id := this.GetString("works_id")
	intId,_ := strconv.Atoi(works_id)
	orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",intId).Filter("Status",1).OrderBy("-id").One(&works)
	if (works_id == "" || works.Id == 0){
		this.JsonResult(0,"获取证书信息成功","")
	}else{
		works_copyright := models.WorksCopyright{}
		works_files := models.WorksFiles{}
		orm.NewOrm().QueryTable(new(models.WorksCopyright).TableName()).Filter("WorksId",works.Id).Filter("Status",1).OrderBy("-id").One(&works_copyright)
		orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId",works.Id).Filter("Status",1).OrderBy("-id").One(&works_files)
		ResCopyright := models.ResCopyrightPC{}
		ResCopyright.Id     		=  works.Id
		ResCopyright.Hash     		=  works_files.CommonHash 
		ResCopyright.BlockHash    	=  works_copyright.Txid
		ResCopyright.Files     		=  works.WorksCertificatepc
		this.JsonResult(1,"获取证书信息成功",ResCopyright)
	}
}
//执行获取证书详情的操作
func (this *Works) Details(){
	if this.Ctx.Request.Method == "POST" {
		works := models.Works{}
		ReqCertificate := models.ReqCertificate{}
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &ReqCertificate); err == nil {
			intId,_ := strconv.Atoi(ReqCertificate.Id)
			orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",intId).OrderBy("-id").One(&works)
			if (ReqCertificate.Id == "" || works.Id == 0){
				this.JsonResult(0,"无效的存证ID","")
			}else{
				//更新点击量
				works.Click		=  works.Click+1
				orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",works.Id).Update(orm.Params{
					"Click": works.Click,
				})
				ResWorksDetails := models.ResWorksDetails{}
				worksfiles := models.WorksFiles{}
				ResWorksDetails.Id     		=  works.Id
				ResWorksDetails.Author     		=  works.AuthorName
				ResWorksDetails.Name     		=  works.Name
				orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId",works.Id).Filter("UserId",works.UserId).OrderBy("-id").One(&worksfiles)
				ResWorksDetails.Files     		=  worksfiles.FileData
				if works.Cover == ""{
					ResWorksDetails.Image     		=  utils.FileOne("static/resource/images/videos/")
				}else{
					ResWorksDetails.Image     		=  works.Cover
				}
				ResWorksDetails.Click     		=  works.Click
				ResWorksDetails.Like     		=  works.Like
				ResWorksDetails.Status     		=  works.Status
				ResWorksDetails.Time     		=  works.CreateTime
				this.JsonResult(1,"获取存证详情成功",ResWorksDetails)
			}
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}
//获取喜欢作品的操作
func (this *Works) Like(){
	if this.Ctx.Request.Method == "POST" {
		works := models.Works{}
		ReqCertificate := models.ReqCertificate{}
		var  err error
		if err = json.Unmarshal(this.Ctx.Input.RequestBody, &ReqCertificate); err == nil {
			intId,_ := strconv.Atoi(ReqCertificate.Id)
			orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",intId).OrderBy("-id").One(&works)
			if (ReqCertificate.Id == "" || works.Id == 0){
				this.JsonResult(0,"无效的存证ID","")
			}else{
				//更新点击量
				works.Like		=  works.Like+1
				orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",works.Id).Update(orm.Params{
					"Like": works.Like,
				})
				this.JsonResult(1,"喜欢本作品成功","")
			}
		}else{
			this.JsonResult(0,"无效的参数值","")
		}
	}else{
		this.JsonResult(0,"无效的提交方式","")
	}
}





