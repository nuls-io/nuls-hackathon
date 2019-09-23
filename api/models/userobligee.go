package models

import (
	"github.com/astaxie/beego/orm"
)

type UserObligee struct {
	Id 			int
	UserId 		int
	WorksId 	int64
	Realname	string
	IdType	    int
	IdNumber	string
	CreateTime  int64
}
//管理员用户权利表
func (m *UserObligee) TableName() string {
	return TableName("user_obligee")
}
//获取全部的数据
func (m *UserObligee) GetAllUser() []*UserObligee {
	var (
		info UserObligee
	)
	list := make([]*UserObligee, 0)

	info.Query().All(&list)
	return list
}
func (m *UserObligee) Query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}
////CURD的操作
//添加
func (m *UserObligee) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *UserObligee) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *UserObligee) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}