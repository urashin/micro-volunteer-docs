
create_springboot_yml()
{
cat <<EOF > application.yml
line-message:
  api_uri: "${LINE_MESSAGE_API_HOST}:8000/v1/sns/send-request-volunteer"
  accept_button_uri: "${LINE_MESSAGE_API_HOST}"
  ignore_button_uri: "${LINE_MESSAGE_API_HOST}"
  accept_button_label: "${LINE_MESSAGE_ACCEPT_BUTTON_LABEL}"
  ignore_button_label: "${LINE_MESSAGE_IGNORE_BUTTON_LABEL}"

encrypt:
  volunteerdb:
    key: '${ENCRYPT_KEY}'
EOF
}

create_python_config()
{
cat <<EOF > config.py
from os import environ
  
# rename this file into config.py

http_host = environ.get("HTTP_HOST", '${PY_HTTP_HOST}')
http_port = environ.get("HTTP_PORT", 8000)

api_web_prefix = environ.get("API_WEB_PREFIX", "/v1/sns")

line_messaging_web_prefix = environ.get("LINE_MESSAGING_WEB_PREFIX", "/messaging")
line_messaging_channel_access_token = environ.get("LINE_MESSAGING_CHANNEL_ACCESS_TOKEN", "${LINE_MESSAGING_CHANNEL_ACCESS_TOKEN}")
line_messaging_channel_secret = environ.get("LINE_MESSAGING_CHANNEL_SECRET", "${LINE_MESSAGING_CHANNEL_SECRET}")

mysql_host = environ.get("MYSQL_HOST", '${PY_MYSQL_HOST}')
mysql_port = environ.get("MYSQL_PORT", 3306)
mysql_user = environ.get("MYSQL_USER", 'volunteer')
mysql_password = environ.get("MYSQL_PASSWORD", 'volunteer')
mysql_database = environ.get("MYSQL_DATABASES", 'volunteerdb')

java_host = environ.get("JAVA_HOST", '${PY_JAVA_HOST}')
deeplink_host = environ.get("DEEPLINK_HOST", '${DEEPLINK_HOST}')
EOF
}


#1.Dockerのチェック
echo "1-(5)ec2-user が sudo を使用せずに Docker コマンドを実行できることを確認。 "
docker info

# create config file
source ./config.sh
create_springboot_yml
create_python_config
APPLICATION_YML_PATH=`pwd`/application.yml
PYTHON_CONFIG_PY_PATH=`pwd`/config.py


#2.Docker-Composeの導入
#2-(1)ダウンロード
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

#2-(2)実行権限付与
sudo chmod +x /usr/local/bin/docker-compose


#3.Gitのインストール
#3-(1)最新の Docker Engine パッケージをインストール
sudo yum install git

#3-(2)Docksを同期
git clone https://github.com/urashin/micro-volunteer-docs.git
cd micro-volunteer-docs/300_Environment/


#4.DockerのComposeの作成・起動

#4-(1)MySQL（アプリがDB接続するため先に起動）
cd docker-mysql
docker-compose up -d
cd ../

#4-(2)SPRINGBOOT
cd app-compose/app
git clone https://github.com/urashin/micro-volunteer-pf.git
mv ${APPLICATION_YML_PATH} ./micro-volunteer-pf/src/main/resources/
cd micro-volunteer-pf
cd ../..
docker build app/ -t java
docker-compose --file docker-compose-java.yml up -d
cd ../



# (3)Python
cd app-compose/app
git clone https://github.com/urashin/micro-volunteer-pf-python.git
mv ${PYTHON_CONFIG_PY_PATH} ./micro-volunteer-pf-python/
cd micro-volunteer-pf-python
docker build ./ -t python_comp
cd ../..
docker-compose --file docker-compose-python.yml up -d



