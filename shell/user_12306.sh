#!/bin/bash

# 把12306泄露的账号密码录入数据库中
# 1.文件名由参数传入，没有则中止脚本
# 2.把文件内容排序
# 
############################
function insertMysql {
        IFS_OLD=$IFS
	if [ -n "$1" ]
	then
		IFS='----'
		i=1
		for val in $1
		do 
			if [ -n "$val" ]
			then
				data[$i]=$val
				i=$[ $i+1 ]
			fi
		done
		sql="insert into t_user(username,password,truename,idcard,field_1,mobile,email) values('${data[1]}','${data[2]}','${data[3]}','${data[4]}','${data[5]}','${data[6]}','${data[7]}')"
		#echo $sql
		mysql hacker -uroot -p123456 -e $sql
		IFS=$IFS_OLD
	fi
}
############################
if [ -z "$1" ]
then
	echo '请提供12306正确的数据文档'
	exit
fi

if [ -e $1 ] && [ -r $1 ]
then
	#IFS_OLD=$IFS
	cat $1 | while read onedata
	do
		insertMysql $onedata
	#	# onedata 是一行数据
	#	echo $onedata
	#	v=''
	#	IFS='----'
	#	for val in $onedata
	#	do
	#		v=$v' '$val
	#	done
	#	echo $v
	#	IFS=$IFS_OLD
	done

else 
	echo '该文件不存在或者不可读取'
	exit
fi
