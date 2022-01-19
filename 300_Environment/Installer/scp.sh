source ./env.sh

if [ ! -f ${SSH_KEY} ]
then
        echo "指定されたssh_keyファイル${SSH_KEY}は存在しません"
        exit 0
fi

echo ${1}

if [ ! -f ${1} ]
then
	echo "指定されたファイル${1}は存在しません"
	exit 0
fi

scp  -i ${SSH_KEY} ${1} ${USER_NAME}@${AWS_HOST}:~/


