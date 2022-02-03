# macからawsにmicro-volunteer環境構築を行う方法

## 構築対象
[こちらの資料](https://github.com/urashin/micro-volunteer-docs/blob/master/200_SystemDesign/210_SystemConfiguration/micro-volunteer_SystemConfiguration.pdf)のawsに該当する部分の構築

## 構築手順
#### ローカルにドキュメントごとInstallerを取得
```
git clone https://github.com/urashin/micro-volunteer-docs.git
```

#### mac用のInstallerまで移動
```
cd micro-volunteer-docs/300_Environment/Installer/mac_installer
```

#### aws接続用の鍵ファイルを配置
```
cp (かぎファイルのパス）tokyo_oss_party_2021_11.pem ./aws.pem
chmod 600 aws.pem
```

#### awsにInstallerをコピー
```
sh deploy.sh ec2-(各自に割り当てられたホスト名).compute.amazonaws.com
```

#### EC2に入り、install前半を実行
```
sh connect.sh
tar xvzf micro_volunteer_install.tgz
cd micro_volunteer_install
sh Install_step1.sh
```

#### 一度、EC2から抜ける
```
exit
```

### EC2に入り直し、install後半を実行
```
sh connect.sh
cd micro_volunteer_install
sh Install_step2.sh
```

### 完了
