/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-07-26 17:56:47
 * @LastEditTime: 2019-08-31 16:35:30
 * @LastEditors: Please set LastEditors
 */
package models

//用户登录成功返回信息结构体
type ResLogin struct {
	Id 				int     	`json:"user_id"`
	Username        string  	`json:"username"`
	Mobile      	string 		`json:"mobile"`
	Email      		string 		`json:"email"`
	Token        	string 		`json:"api_token"`
	Types        	int 		`json:"user_types"`
}
//用户返回信息结构体
type ResUserInfo struct {
	Id 				int     	`json:"user_id"`
	Username        string  	`json:"username"`
	Mobile      	string 		`json:"mobile"`
	NickName        string 		`json:"nick_name"`
	Avatar          string 		`json:"image"`
}
//定义信息返回结构体
type ResDataStruct struct {
	Data interface{} `json:"data"`
}
//用户权利人返回信息结构体
type ResObligeeList struct {
	Id      		int 		`json:"obligee_id"`
	Realname 		string		`json:"real_name"`
}
//定义首页用户,提示信息返回结构体
type ResIndexUser 	struct{
	User		interface{}		`json:"user_info"`
}
//定义首页提示信息返回结构体
type ResIndexArticle struct{
	Works		interface{}		`json:"works_info"`
}
//定义我的存证详情信息返回结构体
type MyCreationInfo struct{
	Id 				int     	`json:"works_id"`
	Name        	string  	`json:"works_name"`
	Types      		string 		`json:"works_types"`
	Obligee      	string 		`json:"works_obligee"`
	AuthorName      string 		`json:"works_author"`
	CreateNature    string 		`json:"works_create_nature"`
	CopyrightNotice string 		`json:"works_notice"`
	Status     		string 		`json:"works_status"`
	CreateTime     	int64 		`json:"works_time"`
	FileData     	interface{} `json:"works_files"`
}
type MyWorksCert struct{
	Id 				int     	`json:"works_id"`
	WorksCertificate  interface{} `json:"works_cert"`
}
//定义和区块交互返回信息结构体
type ResBlockUser struct {
	Success  				bool `json:"success"`
	Data   					string  `json:"data"`
	Msg         			string `json:"msg"`
}
//定义作品和区块交互返回信息结构体
type ResBlockWorks struct{
	Success    				bool	`json:"success"`
	Data					string	`json:"data"`
	Msg						string	`json:"msg"`
}
//节点走势图(启动时间)
type  ResNodeTime	struct{
	Status		string `json:"status"`
	Data		ResNodeTimeData
}
type  ResNodeTimeData	struct{
	ResultType		string `json:"resultType"`
	Result			[]*ResNodeTimeResult
}
type  ResNodeTimeResult	struct{
	Metric			ResNodeTimeMetric
	Value			[]interface{}  `json:"value"` 
}
type  ResNodeTimeMetric	struct{
	Name			string `json:"__name__"`
	Instance		string `json:"instance"`
	Job				string `json:"job"`
}
//节点走势图(内存使用率)
type  ResNodeRAM	struct{
	Status		string `json:"status"`
	Data		ResNodeRAMData
}
type  ResNodeRAMData	struct{
	ResultType		string `json:"resultType"`
	Result			[]*ResNodeRAMResult
}
type  ResNodeRAMResult	struct{
	Metric			ResNodeRAMMetric
	Values			[][]interface{}  `json:"values"`
}
type  ResNodeRAMMetric	struct{
	Instance			string `json:"instance"`
	Job				string `json:"job"`
}
type  ResNodeAA	struct{
	ParamSlice		interface{} `json:"ParamSlice"`
}
//节点走势图(存储空间剩余)
type  ResNodeROM	struct{
	Status				string `json:"status"`
	Data				ResNodeROMData
}
type  ResNodeROMData	struct{
	ResultType			string `json:"resultType"`
	Result				[]*ResNodeROMResult
}
type  ResNodeROMResult	struct{
	Metric				ResNodeROMMetric `json:"metric"`
	Values				interface{}  `json:"values"`
}
type  ResNodeROMMetric	struct{
	Device				string `json:"device"`
	Fstype				string `json:"fstype"`
	Instance			string `json:"instance"`
	Job					string `json:"job"`
	Mountpoint			string `json:"mountpoint"`
}
//用户PC端个人中心返回结构体
type ResUserInfoPC struct {
	Id 				int     	`json:"user_id"`
	Username        string  	`json:"username"`
	Types       	int  		`json:"user_type"`
	Images       	string  	`json:"user_image"`
	Time       		int64  		`json:"regtime"`
	RealName       	string  	`json:"realname"`
	Status       	int  		`json:"real_status"`
	Video       	int64  		`json:"copyright_video"`
	Audio       	int64  		`json:"copyright_audio"`
	Image       	int64  		`json:"copyright_images"`
	Files       	int64  		`json:"copyright_files"`
	Other       	int64  		`json:"copyright_other"`
	Tort       		int  		`json:"check_other"`
	Apply       	int64  		`json:"check_rights_protection"`
	Offline       	int 		`json:"check_offline_notice"`
	Successful      int  		`json:"check_successful_offline"`
}
//用户PC端账户信息返回结构体
type ResUserPC struct {
	Id 				int     	`json:"user_id"`
	Username        string  	`json:"username"`
	Types       	int  		`json:"user_type"`
	Time       		int64  		`json:"regtime"`
	RealName       	string  	`json:"realname"`
	Status       	int  		`json:"real_status"`
	EnterpriseName  string  	`json:"enterprise_name"`
	ContactNumber   string  	`json:"contact_number"`
}
//执行区块证书信息返回结构体
type ResCopyrightPC struct {
	Id       	 	int  		`json:"works_id"`
	Hash       	 	string  	`json:"files_hash"`
	BlockHash       string  	`json:"block_hash"`
	Files       	string  	`json:"works_files"`
}
//执行作品列表信息返回结构体
type ResWorksList struct {
	Data       	 	interface{}  		`json:"data"`
	Counts       	int64 				`json:"iTotalDisplayRecords"`
}
//执行定义监测结果信息返回结构体
type ResMonitorList struct {
	Data       	 	interface{}  		 `json:"data"`
	Counts       	int64 				 `json:"iTotalDisplayRecords"`
	Statistics      ResMonitorStatistics `json:"monitor_statistics"`
}
//监测统计信息
type ResMonitorStatistics struct {
	Works       	int64 				`json:"works_count"`
	Hour       		int64				`json:"hours_count"`
}
//执行维权结果列表返回结构体
type ResDefendList struct {
	Data       	 	interface{}  		 `json:"data"`
	Counts       	int64 				 `json:"iTotalDisplayRecords"`
	Statistics      ResDefendStatistics `json:"monitor_statistics"`
}
type ResDefendStatistics struct {
	SendOffline       	int					`json:"send_offline_count"`
	Offline       		int					`json:"offline_count"`
	Defend       		int64				`json:"defend_count"`
}
//执行实名认证返回信息
type ResVerified struct {
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
	Status      			int 		`json:"real_status"`
	CreateTime      		int64		`json:"start_time"`
}
//定义和区块交互(用户)返回信息结构体v2版本
type ResBlockUserV2 struct {
	ErrCode  					int 			`json:"ErrCode"`
	Msg   						string  		`json:"Msg"`
	UserRegResult         		UserRegResult 	`json:"UserRegResult"`
}
//区块用户信息v2版本
type UserRegResult struct {
	Did       		string 				`json:"Did"`
	RegUser       	RegUserv2			`json:"RegUser"`
}
type RegUserv2 struct {
	Username       			string 				`json:"Username"`
	Usertype       			int 				`json:"Usertype"`
	RegisterationTime       string 				`json:"RegisterationTime"`
	ProxyPlatformID       	string 				`json:"ProxyPlatformID"`
	Person       			ResBlockPersonv2 	`json:"Person"`
	Company       			ResBlockCompanyv2 	`json:"Company"`
}
type ResBlockPersonv2 struct {
	Name       				string 				`json:"Name"`
	Gender       			int 				`json:"Gender"`
	Id       				string 				`json:"Id"`
	PhoneNum       			string 				`json:"PhoneNum"`
	Address       			string 				`json:"Address"`
	Nation       			string 				`json:"Nation"`
}
type ResBlockCompanyv2 struct {
	Name       				string 				`json:"Name"`
	CreditCode       		string				`json:"CreditCode"`
	ContactPerson       	string 				`json:"ContactPerson"`
	ContactPhone       		string 				`json:"ContactPhone"`
}
//定义作品和区块交互返回信息结构体v2
type ResBlockWorksv2 struct{
	ErrCode    				int		`json:"ErrCode"`
	Msg    					string	`json:"Msg"`
	Result    				ResBlockWorksResultv2	`json:"Result"`
}
type ResBlockWorksResultv2 struct{
	CertificationID			string	`json:"CertificationID"`
	IssuerSignature			string	`json:"IssuerSignature"`
	ApplicantSignature		string	`json:"ApplicantSignature"`
	BlockID					string	`json:"BlockID"`
	TxID					string	`json:"TxID"`
}
//定义作品详情返回详情
type ResWorksDetails struct{
	Id    						int		`json:"works_id"`
	Author    					string	`json:"works_author"`
	Name    					string	`json:"works_name"`
	Status    					int	    `json:"works_status"`
	Files    					string	`json:"works_files"`
	Time    					int64	`json:"works_time"`
	Image    					string	`json:"works_videos_image"`
	Click    					int	    `json:"works_click"`
	Like    					int		`json:"works_like"`
}
