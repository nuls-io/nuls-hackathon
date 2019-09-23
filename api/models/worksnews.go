package models

import (
	"github.com/astaxie/beego/orm"
)

type WorksNews struct {
	Id 			int
	UserId 		int
	WorksId   	int
	Title       string
	Content 	string
	CreateTime  int64
	Status 		int
	Types 		int
}
//管理员用户表
func (m *WorksNews) TableName() string {
	return TableName("works_news")
}
////CURD的操作
//添加
func (m *WorksNews) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *WorksNews) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *WorksNews) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}