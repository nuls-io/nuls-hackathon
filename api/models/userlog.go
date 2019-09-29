package models

import (
	"github.com/astaxie/beego/orm"
)

type UserLog struct {
	Id 			int
	UserId 		int64
	UserType   	int
	Types    	int
	LoginIp 	string
	Content	   	string
	Result		string
	CreateTime	int64
	Status		int
	Optime 		int64
}
//前端用户操作日志表
func (m *UserLog) TableName() string {
	return TableName("user_log")
}
////CURD的操作
//添加
func (m *UserLog) Insert() error {
	o := orm.NewOrm()
	if _, err := o.Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *UserLog) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *UserLog) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}
