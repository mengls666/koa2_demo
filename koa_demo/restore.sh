#!/bin/bash
read  -p "请输入数据库用户名：（默认：root）" user

if [ -z "${user}" ];then
	user='root'
fi
read  -p "请输入要恢复的数据库名：" db
read  -p "请输入mysql安装目录（默认：/usr/local/mysql）：" path
if [ -z "${path}" ];then
	path='/usr/local/mysql'
fi
read  -p "请输入备份文件名(默认:backup.sql)：" filename
if [ -z "${filename}" ];then
	filename='backup.sql'
fi

${path}/bin/mysql -u ${user} -p -D ${db} < ${filename}