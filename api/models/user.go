package models

import (
	"github.com/astaxie/beego/orm"
)

type User struct {
	Id 			int
	Username 	string
	Mobile   	string
	AreaCode    string
	Password 	string
	Salt	    string
	Realname	string
	RegisterIp	string
	Avatar		string
	ApiToken	string
	Status 		int
	CreateTime  int64
	NickName 	string
	UserGuuid	string
	Email		string
	Types		int
}
//管理员用户表
func (m *User) TableName() string {
	return TableName("user")
}
//获取全部的数据
func (m *User) GetAllUser() []*User {
	var (
		info User
	)
	list := make([]*User, 0)

	info.Query().All(&list)
	return list
}
func (m *User) Query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}
////CURD的操作
//添加
func (m *User) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *User) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *User) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}
