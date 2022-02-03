# macからawsにmicro-volunteer環境構築を行う方法

## 1. 構築対象
[こちらの資料](https://github.com/urashin/micro-volunteer-docs/blob/master/200_SystemDesign/210_SystemConfiguration/micro-volunteer_SystemConfiguration.pdf)のawsに該当する部分の構築

## 2. 構築手順（前半）
#### 2.1 ローカルにドキュメントごとInstallerを取得
```
git clone https://github.com/urashin/micro-volunteer-docs.git
```

#### 2.2 mac用のInstallerまで移動
```
cd micro-volunteer-docs/300_Environment/Installer/mac_installer
```

#### 2.3 aws接続用の鍵ファイルを配置
```
AWS_KEY=(aws接続に使う鍵ファイルのパス)
cp ${AWS_KEY} ./aws.pem
chmod 600 aws.pem
```

#### 2.4 awsにInstallerをコピー
```
AWS_HOST=(awsのホスト名、例：ec2-xxxxxxxxxxxxx.compute.amazonaws.com ）
sh deploy.sh ${AWS_HOST}
```

#### 2.5 EC2に入り、install前半を実行
```
sh connect.sh
tar xvzf micro_volunteer_install.tgz
cd micro_volunteer_install
sh Install_step1.sh
```

#### 2.6 一度、EC2から抜ける
```
exit
```


## 3. 構築手順（後半）
### 3.1 EC2に入り直し、install後半を実行
```
sh connect.sh
cd micro_volunteer_install
sh Install_step2.sh
```


## 4. 完了
### 4.1 awsから抜ける
```
exit
```
