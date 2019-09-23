package models

import (
	"github.com/astaxie/beego/orm"
)

type WorksFiles struct {
	Id 			int
	UserId 		int
	WorksId   	int64
	Types    	int
	CreateTime  int64
	FileData	string
	Status 		int
	UpdateTime 	int64
	Hash 		string
	Sizes 		string
	CommonHash  string
}
//管理员用户表
func (m *WorksFiles) TableName() string {
	return TableName("works_files")
}
func (m *WorksFiles) Query() orm.QuerySeter {
	return orm.NewOrm().QueryTable(m)
}
////CURD的操作
//添加
func (m *WorksFiles) Insert() error {
	if _, err := orm.NewOrm().Insert(m); err != nil {
		return err
	}
	return nil
}
//读取
func (m *WorksFiles) Read(fields ...string) error {
	if err := orm.NewOrm().Read(m, fields...); err != nil {
		return err
	}
	return nil
}
//更新数据
func (m *WorksFiles) Update(fields ...string) error {
	if _, err := orm.NewOrm().Update(m, fields...); err != nil {
		return err
	}
	return nil
}
// func RoleBatchDelete(ids []int) (int64, error) {
// 	query := orm.NewOrm().QueryTable(new(models.WorksFiles).TableName())
// 	num, err := query.Filter("id__in", ids).Delete()
// 	return num, err
// }
//执行批量更新数据
// func (m *WorksFiles) Updates(ids []int,fields ...string) error {
// 	query := orm.NewOrm().QueryTable(TableName)
// 	if num, err := query.Filter("id__in",ids).Update(m, fields...); err != nil {
// 		return num,err
// 	}
// 	return nil
// }