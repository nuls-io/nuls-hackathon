/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-08-18 22:17:32
 * @LastEditTime: 2019-08-31 15:44:45
 * @LastEditors: Please set LastEditors
 */
package models

import (
	"github.com/astaxie/beego/orm"
)

type Works struct {
	Id 					int
	UserId 				int
	ObligeeId   		int
	Name    			string
	AuthorName 			string
	Types	    		int
	CreateNature		int
	CopyrightNotice		string
	CreateTime  		int64
	Status 				int
	UpdateTime 			int64
	WorksCertificate 	string
	FileData 			string
	// FileData 			[]*WorksFileData `orm:"-"`
	// FileData 			[]*WorksFileData `orm:"reverse(many)"`
	PublishStatus 		int
	WorksCertificatepc 	string
	Cover 				string
	Click 				int
	Like 				int
}
//管理员用户表[]*Menu `orm:"-"` 
func (m *Works) TableName() string {
	return TableName("works")
}
////CURD的操作
//添加
func (m *Works) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *Works) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *Works) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}