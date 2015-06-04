#!/bin/bash

#需要发送的收件人
users=('opdss@qq.com' '479531993@qq.com')
#需要备份的邮箱
databases=('lxdSystem' 'humhub' 'zentao' 'wecenter' 'test')
#备份文件名
backfile=`date +'%Y%m%d-%H%M%S'`'.sql'
#msyql配置
mysql_host='127.0.0.1'
mysql_user='root'
mysql_pass='123456'

mysql=`which mysql`
mysqldump=`which mysqldump`
#mysqldump="/usr/local/mysql/bin/mysqldump"

${mysqldump} -h${mysql_host} -u${mysql_user} -p${mysql_pass} --add-drop-table --databases ${databases[*]} 1>${backfile}

if [ -r ${backfile} ]
then
    for u in  ${users[*]}
    do
        echo $u
        echo "mysql(${databases[*]}) bak success" | mutt $u -s "mysql备份数据" -a $backfile
    done
else
    echo 'error'
fi