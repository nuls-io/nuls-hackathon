/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-26 17:56:47
 * @LastEditTime: 2019-08-31 16:54:54
 * @LastEditors: Please set LastEditors
 */
package models

//用户注册请求信息结构体
type ReqRegister struct {
	Mobile      	string 		`json:"mobile"`
	Password 		string		`json:"password"`
	Repassword 		string		`json:"repassword"`
}
//用户登录请求信息结构体
type ReqLogin struct {
	Mobile      	string 		`json:"mobile"`
	Password 		string		`json:"password"`
}
//短信验证码请求信息结构体
type ReqSendMobile struct{
	Mobile      	string 		`json:"mobile"`
	AreaCode 		string		`json:"area_code"`
	Type			int		     `json:"types"`
}
//忘记密码请求信息结构体
type ReqForPwd struct{
	Mobile      	string 		`json:"mobile"`
	Email 			string		`json:"email"`
	Code 			string		`json:"code"`
	Password 		string		`json:"password"`
	Repassword 		string		`json:"repassword"`
	Type			int		     `json:"types"`
}
//用户昵称修改请求信息结构体
type ReqNickName struct{
	NickName      	string 		`json:"nick_name"`
}
//用户密码修改请求信息结构体
type ReqPwd struct{
	Mobile      	string 		`json:"mobile"`
	Code 			string		`json:"code"`
	Password 		string		`json:"password"`
	Repassword 		string		`json:"repassword"`
}
//添加权利人请求信息结构体
type ReqObligee struct{
	IdType      	string 		`json:"type"`
	IdNumber 		string		`json:"number"`
	Realname 		string		`json:"real_name"`
}
//定义存证信息请求结构体
type ReqCopryRight struct {
	// ObligeeId      	string 		`json:"obligee"`
	Name 			string		`json:"works_name"`
	AuthorName 		string		`json:"works_author"`
	Types 			string		`json:"works_type"`
	PublishStatus 	string		`json:"works_pstatus"`
	CreateNature 	string		`json:"works_create_nature"`
	CopyrightNotice string		`json:"works_notice"`
	FileId			string      		`json:"works_files"`
	Obligee		[]*WorksObligeeData      `json:"obligee_data"`
}
//作品文件封装
type WorksFileData struct {
	Id    string  	`json:"file_id"`
	Url   string  	`json:"file_data"`
}
//权利人列表
type WorksObligeeData struct {
	Type    	string  	`json:"types"`
	Realname   	string  	`json:"real_name"`
	IdNumber   	string  	`json:"id_number"`
}
//定义上传信息请求结构体
type ReqUpload struct {
	Types      		string 		`json:"types"`
	Upfile 			string		`json:"upfile"`
}
//定义我的创作上传信息
type ReqMyCreation struct {
	Types      		string 		`json:"works_type"`
	// Page      		string 		`json:"page"`
}
//定义首页已存证信息
type ReqIndex struct {
	Page      		string 		`json:"page"`
}
//定义查看证书的操作
type ReqCertificate struct {
	Id      		string 		`json:"works_id"`
}
//区块用户注册配置
type ReqBlockUser struct {
	Address					string		`json:"address"`
	Password				string		`json:"password"`
	Authorization			string		`json:"authorization"`
	Username				string		`json:"username"`
	UserType				string		`json:"userType"`
	RegisterationTime		string		`json:"registerationTime"`
	ProxyPlatformID			string		`json:"proxyPlatformID"`
	Person					ReqBlockPerson		`json:"person"`
	Company					ReqBlockCompany		`json:"company"`
}
//个人信息
type ReqBlockPerson struct {
	Name 			string			`json:"name"`
	Gender          string			`json:"gender"`
	ID				string			`json:"id"`
	PhoneNum		string			`json:"phoneNum"`
	Address			string			`json:"address"`
	Nation			string			`json:"nation"`
}
//企业信息
type ReqBlockCompany  struct {
	Name			string			`json:"name"`
	Creditcode		string			`json:"creditCode"`
	Contactpersion	string			`json:"contactPerson"`
	Contactphone	string			`json:"contactPhone"`
}
//区块浏览器作品配置
type  ReqBlockWorks	struct {
	Address					string		`json:"address"`
	Password				string		`json:"password"`
	Authorization			string		`json:"authorization"`
	CertificationName		string		`json:"certificationName"`
	PowerinfoID				string		`json:"powerinfoId"`
	Catalog					int			`json:"catalog"`
	Workname				string		`json:"workName"`
	Fingerprint				string		`json:"fingerPrint"`
	OriginalFileDigest		string		`json:"originalFileDigest"`
	Inventiontype			int			`json:"inventionType"`
	ProductionTime			string		`json:"productionTime"`
	Publishedtime			string		`json:"publishedTime"`
	RightApplyTime			string		`json:"rightApplyTime"`
	ApplicantID				string		`json:"applicantId"`
	ApplicantName			string		`json:"applicantName"`
	IssuerID				string		`json:"issuerId"`
	Issuer					string		`json:"issuer"`
	RightDescription		ReqRightDescription		`json:"rightDescription"`
	FileInfo				ReqFileInfo				`json:"fileInfo"`
}
//定义区块权利人配置
type ReqRightDescription	struct {
	RightOwnerName			string		`json:"ownerName"`
	RightOwnerID			string		`json:"ownerId"`
	RightExpiration			string		`json:"rightExpiration"`
	RightSourceType			string		`json:"rightSourceType"`
}
//定义区块文件信息配置
type ReqFileInfo	struct {
	Filetype				int			`json:"fileType"`
	Sizes					int			`json:"sizes"`
	FileHash				string		`json:"fileHash"`
	StorageLocationURL		string		`json:"storageLocationURL"`
}
//邮箱验证码请求信息结构体
type ReqSendMail struct{
	Email      		string 		`json:"email"`
	Type			int		     `json:"types"`
}
//修改密码请求信息结构体
type ReqPassword struct {
	OldPassword      		string 		`json:"opassword"`
	Password      			string 		`json:"password"`
	RePassword      		string 		`json:"repassword"`
}
//实名认证请求信息结构体
type ReqVerified struct {
	RealName      			string 		`json:"real_name"`
	Types      				int 		`json:"user_type"`
	Number      			string 		`json:"Id_number"`
	ValidityPeriod      	string 		`json:"validity_period"`
	Images1      			string 		`json:"images1"`
	Images2      			string 		`json:"images2"`
	Mobile      			string 		`json:"mobile"`
	Company      			string 		`json:"company_name"`
	CompanyNumber      		string 		`json:"company_number"`
	CompanyValid      		string 		`json:"company_valid"`
	CompanyImage      		string 		`json:"company_image"`
	EntrustImage      		string 		`json:"entrust_image"`
}
//定义API新增,设置请求结构体
type ReqApiEdit struct {
	Id      				string 		`json:"api_id"`
	Title      				string 		`json:"api_title"`
	Types      				int 		`json:"api_types"`
	Type      				int 		`json:"api_type"`
}
//定义API重置,删除请求结构体
type ReqApiStatus struct {
	Id      				string 		`json:"api_id"`
	Type      				int 		`json:"api_type"`
}
//执行PCdaunt请求信息结构体
type ReqProof struct {
	Name 					string			`json:"works_name"`
	AuthorName 				string			`json:"works_author"`
	Types 					string			`json:"works_type"`
	PublishStatus 			string			`json:"works_obligee"`
	FileId					string      	`json:"works_files"`
	Cover					string      	`json:"works_cover"`
	Click					int      	    `json:"works_click"`
}
//执行存证列表请求信息结构体
type ReqWorks struct {
	Page 					int				`json:"start"`
	Length 					int				`json:"length"`
	Name 					string			`json:"name"`
	Types 					int				`json:"types"`
	StartTime				int64      		`json:"start_time"`
	EndTime					int64      		`json:"end_time"`
}
//执行发启监测请求信息结构体
type ReqWorksMonitor struct {
	Id 						int8				`json:"works_id"`
	CreateTime 				uint8				`json:"works_check_time"`
	Fee						float64      		`json:"works_check_fee"`
}
//执行定义开启检测请求信息结构体(前端不传递,后端需要)
type ReqMonitorTask struct {
	Months      uint8         	`json:"months"`
	BeginTime   int64         	`json:"begin_time"`
	EndTime     int64         	`json:"end_time"`
	Fee         float64       	`json:"fee"`
	WorksTypes  int           	`json:"works_types"` //一次监测任务，只能监测同一种作品类型的作品，冠勇限制了
	MonitorData MonitorDatas   	
}
//数据，可以多个值
type MonitorDatas struct {
	WorksId     int    `json:"works_id"`
	WorksName   string `json:"works_name"`
	WorksUrl    string `json:"sample_url"`   //作品网址，格式如：http://www.morvoo.com/works/?id=1
	AuthorName  string `json:"author_name"`  //作品作者
	ReleaseTime string `json:"release_time"` //作品发布时间，格式如：2019-7-1 00:00:00
}
type MonitorList []struct {
	SourceId          string `json:"sourceId"`
	UserName          string `json:"userName"`
	SampleUrl         string `json:"sampleUrl"`
	SampleFingerprint string `json:"sampleFingerprint"`
	SampleTitle       string `json:"sampleTitle"`
	ReleaseTime       string `json:"releaseTime"`
	SampleId          string `json:"sampleId"` //注意：样本ID = 监测批次ID+"-"+作品ID，用-分隔，监测批次ID即tb_monitor_sample表中的ID
}
//执行监测结果列表请求信息结构体
type ReqMonitor struct {
	Page 					int				`json:"start"`
	Length 					int				`json:"length"`
	Name 					string			`json:"name"`
	Website 				string			`json:"website"`
	StartTime				int64      		`json:"start_time"`
	EndTime					int64      		`json:"end_time"`
}
//执行申请维权请求信息结构体
type ReqDefend struct {
	Id 						int				`json:"monitor_id"`
	Contacts 				string			`json:"contacts"`
	Mobile 					string			`json:"mobile"`
	Contents 				string			`json:"description"`
}
//执行维权结果列表请求信息结构体
type ReqDefendList struct {
	Page 					int				`json:"start"`
	Length 					int				`json:"length"`
}
//执行侵权结果列表请求信息结构体
type ReqTortDetails struct {
	Id 						int				`json:"works_id"`
	Page 					int				`json:"start"`
	Length 					int				`json:"length"`
}
//执行发函下线请求结构体
type ReqOffLineMail struct {
	ResultId []int `json:"result_id"` //tb_monitor_result中的id
}
//区块浏览器v2版本配置
type  ReqBlockWorksv2	struct {
	CertificationName		string
	PowerinfoID				string
	Catalog					int
	WorkName				string
	Fingerprint				string
	OriginalFileDigest		string
	InventionType			int
	ProductionTime			string
	PublishedTime			string
	RightApplyTime			string
	ApplicantID				string
	ApplicantName			string
	IssuerID				string
	Issuer					string
	RightDescription		ReqRightDescriptionv2
	FileInfo				ReqFileInfov2
}
//定义区块权利人配置v2
type ReqRightDescriptionv2	struct {
	RightOwnerID			string
	RightOwnerName			string
	RightExpiration			string
	RightSourceType			string
}
//定义区块文件信息配置v2
type ReqFileInfov2	struct {
	FileType				int
	Sizes					int
	FileHash				string
	StorageLocationURL		string
}
// //短视宝用户和链交互
// type ReqBlockUserV struct {
// 	Address					string
// 	Password				string
// 	Authorization			string
// 	ProxyPlatformID			string
// 	Person					ReqBlockPerson
// 	Company					ReqBlockCompany
// }