
#1.Docker関連パッケージのインストール
echo "1-(1)インスタンスでインストールされているパッケージとパッケージキャッシュを更新。"
sudo yum update -y

echo "1-(2)最新の Docker Engine パッケージをインストール。(Amazon Linux2）"
sudo amazon-linux-extras install docker

echo "1-(3)Docker サービスを開始します。"
sudo service docker start
sudo service docker status
sudo systemctl enable docker

echo "1-(4)ec2-user を docker グループに追加。"
sudo usermod -a -G docker ec2-user

echo " 再ログインしてください。"


