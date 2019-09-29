package models

import (
	"github.com/astaxie/beego/orm"
)

type WorksCopyright struct {
	Id 					int
	UserId 				int
	WorksId				int64
	WorkName    		string
	Name    			string
	CertificateId 		int64
	Catalog	    		int
	Fingerprint			string
	WorkAbstract		string
	CreateNature		int
	WorkCreateTime		int64
	WorkPublishTime		int64
	WorkApplyTime		int64
	ApplicantId			string
	ApplicantName		string
	IssuerId			string
	IssuerName			string
	RightDescription	string
	FileInfo			string
	Status 				int
	Describe			string
	CertificationId		string
	IssuerSignature		string
	ApplicantSignature	string
	BlockId				string
	Txid				string
	CreateTime  		int64
	UpdateTime 			int64
}
//管理员用户表
func (m *WorksCopyright) TableName() string {
	return TableName("works_copyright")
}
////CURD的操作
//添加
func (m *WorksCopyright) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *WorksCopyright) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *WorksCopyright) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}