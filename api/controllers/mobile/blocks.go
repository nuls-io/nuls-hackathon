/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-29 13:44:45
 * @LastEditTime: 2019-08-25 22:55:05
 * @LastEditors: Please set LastEditors
 */
package mobile

import (
	"time"
	"fmt"
	"strconv"
	"github.com/ShortVideo/api/models"
	"encoding/json"
	"github.com/ShortVideo/api/utils"
	"github.com/astaxie/beego/orm"
	"github.com/astaxie/beego"
	"strings"
)

type Blocks struct {
	Base
}
type header struct{
	Result    				int
	FailureDescription		string
	CertificationID			string
	IssuerSignature			string
	ApplicantSignature		string
	BlockID					string
	TxID					string
}
//执行区块中注册用户(链v1版本)
func (this *Blocks) RegisterUser(){
	userblock :=  [] *models.UserBlock{}
	BlockUser	:=  models.ReqBlockUser{}
	ReqBlockPerson	:=  models.ReqBlockPerson{}
	ReqBlockCompany	:=  models.ReqBlockCompany{}
	ResBlockUser	:=  models.ResBlockUser{}
	blocks_count,_:= orm.NewOrm().QueryTable(new(models.UserBlock).TableName()).Filter("Status",2).Count()
	if blocks_count > 0 {
		orm.NewOrm().QueryTable(new(models.UserBlock).TableName()).Filter("Status",2).All(&userblock)
		for _, v := range userblock {
			if (v.Id != 0 && v.Status == 2){
				ReqBlockPerson.Name 					=  v.Username
				ReqBlockPerson.Gender 					=  "0"
				ReqBlockPerson.ID 						=  ""
				ReqBlockPerson.PhoneNum 				=  v.Username
				ReqBlockPerson.Address 					=  ""
				ReqBlockPerson.Nation 					=  ""
				Personjsons,_:= json.Marshal(ReqBlockPerson)
				//企业信息
				ReqBlockCompany.Name 					=  ""
				ReqBlockCompany.Creditcode 				=  ""
				ReqBlockCompany.Contactpersion 			=  ""
				ReqBlockCompany.Contactphone 			=  ""
				Companyjsons,_:= json.Marshal(ReqBlockCompany)
				//信息集合汇总
				BlockUser.Address 					=  beego.AppConfig.String("blockaddress")
				BlockUser.Password 					=  beego.AppConfig.String("blockpassword")
				BlockUser.Authorization 			=  beego.AppConfig.String("blockauthorization")
				BlockUser.Username 					=  v.Username
				BlockUser.UserType 					=  "2"
				BlockUser.RegisterationTime 		=  time.Unix(v.RegTime, 0).Format("2006-01-02 15:04:05")
				if v.RegPlatform == ""{
					BlockUser.ProxyPlatformID 			=  beego.AppConfig.String("blockregplatform")
				}else{
					BlockUser.ProxyPlatformID 			=  v.RegPlatform
				}
				BlockUser.Person 					=  ReqBlockPerson
				BlockUser.Company 					=  ReqBlockCompany
				var  httpurl string
				if beego.AppConfig.String("runmode") == "prod"{
					httpurl = beego.AppConfig.String("blockurlmain")
				}else{
					httpurl = beego.AppConfig.String("blockurldev")
				}
				//执行curl信息的配置
				url := httpurl + "/copyright/createRegisteredEntity"
				contentType := "application/json"
				res_post :=  utils.CurlPost(url,BlockUser,contentType)
				json.Unmarshal([]byte(res_post), &ResBlockUser)
				// //更新区块交易表记录的操作
				userblocks :=  models.UserBlock{}
				orm.NewOrm().QueryTable(new(models.UserBlock).TableName()).Filter("Id",v.Id).One(&userblocks)
				userblocks.RegPlatform 	=	BlockUser.ProxyPlatformID 
				userblocks.Person 		=	string(Personjsons)
				userblocks.Company 		=	string(Companyjsons)
				userblocks.Describe 	=	res_post
				if ResBlockUser.Success == true {
					userblocks.Code 	=	1
				}else{
					userblocks.Code 	= 	0
				}
				userblocks.UserGuuid 	=	ResBlockUser.Data
				userblocks.UpdateTime 	=	time.Now().Unix()
				if ResBlockUser.Success == true{
					userblocks.Status 		=	1
				}else{
					userblocks.Status 		=	0
				}
				userblocksdb := userblocks.Update()
				//更新用户记录的操作
				user :=  models.User{}
				orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",v.UserId).One(&user)
				user.UserGuuid 	= ResBlockUser.Data
				userdb 	:= user.Update()
				if  (userblocksdb != nil && userdb != nil) {
					fmt.Println("更新失败")
				}else{
					fmt.Println("更新成功")
				}
			}
		}
	}else{
		fmt.Println("暂无数据处理")
	}
}
//执行区块中更新作品归属的操作(链v1版本)
func  (this *Blocks) RegisterWorks(){
	workscopyright 			:= []*models.WorksCopyright{}
	user 					:= models.User{}
	ReqBlockWorks			:= models.ReqBlockWorks{}
	ReqRightDescription		:= models.ReqRightDescription{}
	ReqFileInfo				:= models.ReqFileInfo{}
	ResBlockWorks			:=  models.ResBlockWorks{}
	workscopyright_count,_:= orm.NewOrm().QueryTable(new(models.WorksCopyright).TableName()).Filter("Status",0).Count()
	if workscopyright_count > 0 {
		orm.NewOrm().QueryTable(new(models.WorksCopyright).TableName()).Filter("Status",0).All(&workscopyright)
		for _, v := range workscopyright {
			if (v.Id != 0 && v.Status == 0){
				row := make(map[string]interface{})
				row["works_u"] = orm.NewOrm().QueryTable(new(models.User).TableName()).Filter("Id",v.UserId).One(&user)
				if user.UserGuuid  == ""{
					fmt.Println("暂无和链进行交互")
				}else{
					//查询作品文件归属
					works_files := models.WorksFiles{}
					orm.NewOrm().QueryTable(new(models.WorksFiles).TableName()).Filter("WorksId", v.WorksId).Filter("UserId",v.UserId).OrderBy("id").One(&works_files)
					//添加权利人配置
					user_obligee := models.UserObligee{}
					orm.NewOrm().QueryTable(new(models.UserObligee).TableName()).Filter("WorksId", v.WorksId).Filter("UserId",v.UserId).OrderBy("id").One(&user_obligee)
					//区块权利人的配置
					ReqRightDescription.RightOwnerName			=  user_obligee.Realname
					ReqRightDescription.RightOwnerID			=  ""
					ReqRightDescription.RightExpiration			=  ""
					ReqRightDescription.RightSourceType			=  ""
					RightDescriptionjsons,_:= json.Marshal(ReqRightDescription)
					//区块文件信息的配置
					if v.Catalog == 17{
						ReqFileInfo.Filetype						= 1
					}else if v.Catalog == 23{
						ReqFileInfo.Filetype						= 2
					}else if v.Catalog == 35{
						ReqFileInfo.Filetype						= 3
					}else if v.Catalog == 43{
						ReqFileInfo.Filetype						= 4
					}
					if works_files.Id == 0 {
						ReqFileInfo.Sizes							= 50
						ReqFileInfo.FileHash						= ""
						ReqFileInfo.StorageLocationURL				= ""
					}else{
						num,_ := strconv.Atoi(works_files.Sizes)
						nums := num / 1024
						external_ip := utils.GetExternal()
						external_ip = strings.Replace(external_ip, "\n", "", -1)
						ReqFileInfo.Sizes							= nums
						ReqFileInfo.FileHash						= works_files.Hash
						ReqFileInfo.StorageLocationURL				= external_ip+":"+beego.AppConfig.String("httpport")+"/"+works_files.FileData
					}
					ReqFileInfojsons,_:= json.Marshal(ReqFileInfo)
					//区块作品信息汇总
					ReqBlockWorks.Address 						=  beego.AppConfig.String("blockaddress")
					ReqBlockWorks.Password 						=  beego.AppConfig.String("blockpassword")
					ReqBlockWorks.Authorization 				=  beego.AppConfig.String("blockauthorization")
					ReqBlockWorks.CertificationName 			=  "著作权存证"
					ReqBlockWorks.PowerinfoID 					=  strconv.FormatInt(v.WorksId,10)
					ReqBlockWorks.Catalog 						= v.Catalog
					ReqBlockWorks.Workname 						=  v.WorkName
					// ReqBlockWorks.Fingerprint 					=  v.Fingerprint
					ReqBlockWorks.Fingerprint 					=  ""
					ReqBlockWorks.OriginalFileDigest 			=  ""
					ReqBlockWorks.Inventiontype 				=  v.CreateNature
					ReqBlockWorks.ProductionTime 				=  time.Unix(v.WorkCreateTime, 0).Format("2006-01-02 15:04:05")
					ReqBlockWorks.Publishedtime 				=  time.Unix(v.WorkPublishTime, 0).Format("2006-01-02 15:04:05")
					ReqBlockWorks.RightApplyTime 				=  time.Unix(v.WorkApplyTime, 0).Format("2006-01-02 15:04:05")
					ReqBlockWorks.ApplicantID 					=  user.UserGuuid
					ReqBlockWorks.ApplicantName 				=  ""
					// ReqBlockWorks.ApplicantName 				=  user.Mobile
					ReqBlockWorks.IssuerID 						=  beego.AppConfig.String("blockregissuerid")
					ReqBlockWorks.Issuer 						=  beego.AppConfig.String("blockregissuer")
					ReqBlockWorks.RightDescription 				=  ReqRightDescription
					ReqBlockWorks.FileInfo 						=  ReqFileInfo
					var  httpurl string
					if beego.AppConfig.String("runmode") == "prod"{
						httpurl = beego.AppConfig.String("blockurlmain")
					}else{
						httpurl = beego.AppConfig.String("blockurldev")
					}
					//执行post请求交互的操作
					url := httpurl + "/copyright/deposit"
					contentType := "application/json"
					res_post :=  utils.CurlPost(url,ReqBlockWorks,contentType)
					json.Unmarshal([]byte(res_post), &ResBlockWorks)
					//更新作品区块记录的操作
					copyright :=  models.WorksCopyright{}
					orm.NewOrm().QueryTable(new(models.WorksCopyright).TableName()).Filter("Id",v.Id).One(&copyright)
					copyright.Name 					=	ReqBlockWorks.CertificationName
					copyright.CertificateId 		=	v.WorksId
					copyright.Name 					=	ReqBlockWorks.CertificationName
					copyright.Name 					=	ReqBlockWorks.CertificationName
					copyright.Fingerprint 			=	ReqBlockWorks.Fingerprint
					copyright.WorkAbstract 			=	ReqBlockWorks.OriginalFileDigest
					copyright.ApplicantId 			=	ReqBlockWorks.ApplicantID
					copyright.ApplicantName 		=	ReqBlockWorks.ApplicantName
					copyright.IssuerId 				=	ReqBlockWorks.IssuerID
					copyright.IssuerName 			=	ReqBlockWorks.Issuer
					copyright.RightDescription 		=	string(RightDescriptionjsons)
					copyright.FileInfo 				=	string(ReqFileInfojsons)
					copyright.Describe 				=	res_post
					copyright.CertificationId 		=	ResBlockWorks.Data
					copyright.IssuerSignature 		=	ResBlockWorks.Data
					copyright.ApplicantSignature 	=	ResBlockWorks.Data
					copyright.BlockId 				=	ResBlockWorks.Data
					copyright.Txid 					=	ResBlockWorks.Data
					copyright.UpdateTime 			=	time.Now().Unix()
					if ResBlockWorks.Success == true{
						copyright.Status			= 1
					}else{
						copyright.Status			= 2
					}
					o := orm.NewOrm()
					//开启事务
					err := o.Begin()
					_,copyrightdb := o.Update(&copyright)
					//更新作品的操作
					works :=  models.Works{}
					orm.NewOrm().QueryTable(new(models.Works).TableName()).Filter("Id",v.WorksId).One(&works)
					if copyright.Status == 1 {
						works.Status 		= 1
					}else if copyright.Status == 0 {
						works.Status 		= 0
					}else{
						works.Status 		= 3
					}
					//生成带有信息存证的图
					ImageWorksId             := copyright.CertificationId
					//查询所有的权利者
					userobligee 		:=  []models.UserObligee{}
					orm.NewOrm().QueryTable(new(models.UserObligee).TableName()).Filter("WorksId",works.Id).All(&userobligee)
					var ids string
					for _, v := range userobligee {
						ids = ids+ v.Realname +","
					}
					ImageBlcokTimes          := time.Unix(v.WorkApplyTime, 0).Format("2006年01月02日 15:04:05")
					//PC端证书图片
					worksimagepc 			:= 		this.ImageWordPC(ImageWorksId,user.Mobile,ImageBlcokTimes,works.Cover)
					works.UpdateTime 		= time.Now().Unix()
					works.WorksCertificate 	= worksimagepc
					works.WorksCertificatepc 	= worksimagepc
					_,worksdb 				:= o.Update(&works)
					//更新作品提示信息的操作
					worksnew :=  models.WorksNews{}
					worksnew.UserId 	= works.UserId
					worksnew.WorksId 	= works.Id
					worksnew.Title 		= user.NickName+"刚刚申请办理了[版权存证]业务"
					worksnew.Content 	= user.NickName+"刚刚申请办理了[版权存证]业务"
					worksnew.CreateTime = time.Now().Unix()
					worksnew.Status 	= 1
					worksnew.Types 		= 1
					_,worksnewdb 			:= o.Insert(&worksnew)
					if  (err != nil || copyrightdb != nil || worksdb != nil || worksnewdb != nil) {
						o.Rollback()
						fmt.Println("更新失败")
					}else{
						o.Commit()
						fmt.Println("更新成功")
					}
				}
			}else{
				fmt.Println("数据已处理，无需处理")
			}
		}
	}else{
		fmt.Println("暂无数据处理")
	}
}