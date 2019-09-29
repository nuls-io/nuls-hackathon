/*
 * @Description: In User Settings Edit
 * @Author: your name
 * @Date: 2019-06-28 18:07:38
 * @LastEditTime: 2019-08-18 18:01:25
 * @LastEditors: Please set LastEditors
 */
package models

import (
	"github.com/astaxie/beego/orm"
)

type UserBlock struct {
	Id 				int
	UserId 			int64
	Username 		string
	Usertype 		int
	RegTime   		int64
	RegPlatform 	string
	Person 			string
	Company	    	string
	Describe		string
	Code			int
	UserGuuid		string
	CreateTime  	int64
	UpdateTime  	int64
	Status 			int
}
//管理员用户表
func (m *UserBlock) TableName() string {
	return TableName("user_block")
}
////CURD的操作
//添加
func (m *UserBlock) Insert() error {
	o := orm.NewOrm()
	if _, err := o.Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *UserBlock) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *UserBlock) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}