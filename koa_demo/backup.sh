#!/bin/bash
read  -p "请输入数据库用户名：（默认：root）" user

if [ -z "${user}" ];then
	user='root'
fi
read  -p "请输入要备份的数据库名：" db
read  -p "请输入mysql安装目录（默认：/usr/local/mysql）：" path
if [ -z "${path}" ];then
	path='/usr/local/mysql'
fi
read  -p "请输入导出的文件名(默认:backup.sql)：" filename
if [ -z "${filename}" ];then
	filename='backup.sql'
fi

${path}/bin/mysqldump -u ${user} -p ${db} > ${filename}