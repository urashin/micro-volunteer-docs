source ./env.sh

if [ ! -f ${SSH_KEY} ]
then
        echo "指定されたssh_keyファイル${SSH_KEY}は存在しません"
        exit 0
fi

ssh -i ${SSH_KEY} ${USER_NAME}@${AWS_HOST}


