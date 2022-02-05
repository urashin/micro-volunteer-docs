SSH_KEY=aws.pem
ENCRYPT_KEY="set_encrypt_string_xinn3rMFwiwDQYJKoZIhvcNAQEBBQADSwAwSAJBAPfawZ1qJkJP2j"

create_envfile()
{
cat <<EOF > ./env.sh
SSH_KEY=${SSH_KEY}
USER_NAME=ec2-user
AWS_HOST=${1}

EOF
}



create_config()
{
cat <<EOF > ./micro_volunteer_install/config.sh
# 
# Spring Boot Config
#

# MySQL
MYSQL_HOST=172.25.0.3

# LINE Config
LINE_MESSAGE_API_HOST="${1}"
LINE_MESSAGE_ACCEPT_BUTTON_LABEL="いま行きます！"
LINE_MESSAGE_IGNORE_BUTTON_LABEL="今は無理"

# encrypt key
ENCRYPT_KEY=${ENCRYPT_KEY}


#
# Python Config
#
PY_HTTP_HOST=172.25.0.4
PY_MYSQL_HOST=172.25.0.3
PY_JAVA_HOST=http://172.25.0.2:8080

LINE_MESSAGING_CHANNEL_ACCESS_TOKEN="xxxxxxx_LINE_TOKEN_xxxxxxx"
LINE_MESSAGING_CHANNEL_SECRET="xxxxxxxx_LINE_SECRET_xxxxxxxxxx"
DEEPLINK_HOST="http://example.com"

EOF


}

create_setup_script()
{

cat <<EOF > ./add_handicap.sh
echo "[聴覚しょうがい]を追加"
curl -XPOST -H "Content-Type: application/json" http://${1}:8080/v1/admin/add_handicap_type -d '{"auth_code":"${2}", "handicap_name": "聴覚しょうがい", "icon_path":"1","comment":""}'
echo " "

echo "[車椅子]を追加"
curl -XPOST -H "Content-Type: application/json" http://${1}:8080/v1/admin/add_handicap_type -d '{"auth_code":"${2}", "handicap_name": "車椅子", "icon_path":"2","comment":""}'
echo " "

EOF

}


if [ "${1}" = "" ]
then
        echo "引数としてawsのホストを指定してください"
        exit 0
fi

create_envfile ${1}
create_config ${1}
create_setup_script ${1} ${ENCRYPT_KEY}

tar cvzf ./micro_volunteer_install.tgz ./micro_volunteer_install

source ./env.sh

if [ ! -f ${SSH_KEY} ]
then
        echo "指定されたssh_keyファイル${SSH_KEY}は存在しません"
        exit 0
fi

scp  -i ${SSH_KEY} ./micro_volunteer_install.tgz ${USER_NAME}@${AWS_HOST}:~/


