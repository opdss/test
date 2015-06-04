#!/bin/bash

from='chaixiaogang@7659.com'
fpath='/webserver/workspace/wuxin/script/libaoSend/'
cvs=`date -d 'yesterday' +'%Y%m%d'`'.csv'
res=`php $fpath'index.php'`
if [ "$res" = 'success' ]
then
	if [ -r $cvs ]
	then
		echo "success" |mutt $from -s "礼包数据" -a $cvs
	else
		echo $cvs' is error';
	fi
else
	echo error
fi