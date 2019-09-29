package models

import (
	// "time"
	"github.com/astaxie/beego/orm"
)

type UserLogin struct {
	Id 			int
	UserId 	    int
	LoginIp   	string
	CreateTime  int64
}
//管理员用户表
func (m *UserLogin) TableName() string {
	return TableName("user_login")
}
//获取全部的数据
func (m *UserLogin) GetAllUser() []*UserLogin {
	var (
		info User
	)
	list := make([]*UserLogin, 0)

	info.Query().All(&list)
	return list
}
func (m *UserLogin) Query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}
////CURD的操作
//添加
func (m *UserLogin) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
