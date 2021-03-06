# awsにmicro-volunteer環境構築を行う方法(macの場合)

## 1. 構築対象
[こちらの資料](https://github.com/urashin/micro-volunteer-docs/blob/master/200_SystemDesign/210_SystemConfiguration/micro-volunteer_SystemConfiguration.pdf)のawsに該当する部分の構築

## 2. aws側の設定
### 2.1 EC2インスタンスを起動
#### 2.1.1 ステップ 1: Amazon マシンイメージ (AMI)
```Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type```の「64 ビット (x86)」を選択

#### 2.1.2 ステップ 2: インスタンスタイプの選択 
```t2.medium```を選択

#### 2.1.3 「起動」
### 2.2 キーペアファイルを作成
#### 2.2.1 プライベートキーをダウンロード
このときダウンロードしたプライベートキーは、[「3.3 aws接続用の鍵ファイルを配置」](https://github.com/urashin/micro-volunteer-docs/blob/master/300_Environment/Installer/mac_installer/README.md#33-aws%E6%8E%A5%E7%B6%9A%E7%94%A8%E3%81%AE%E9%8D%B5%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E9%85%8D%E7%BD%AE)で使用するものです。

## 3. 構築手順（前半）
#### 3.1 ローカルにドキュメントごとInstallerを取得
```
git clone https://github.com/urashin/micro-volunteer-docs.git
```

#### 3.2 mac用のInstallerまで移動
```
cd micro-volunteer-docs/300_Environment/Installer/mac_installer
```

#### 3.3 aws接続用の鍵ファイルを配置
```
AWS_KEY=(aws接続に使う鍵ファイルのパス)
cp ${AWS_KEY} ./aws.pem
chmod 600 aws.pem
```
AWS_KEYには[ここ](https://github.com/urashin/micro-volunteer-docs/blob/master/300_Environment/Installer/mac_installer/README.md#22-%E3%82%AD%E3%83%BC%E3%83%9A%E3%82%A2%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E4%BD%9C%E6%88%90)でダウンロードした鍵ファイルを指定してください。

#### 3.4 awsにInstallerをコピー
```
AWS_HOST=(awsのホスト名、例：ec2-xxxxxxxxxxxxx.compute.amazonaws.com ）
sh deploy.sh ${AWS_HOST}
```

#### 3.5 EC2に入り、install前半を実行
```
sh connect.sh
tar xvzf micro_volunteer_install.tgz
cd micro_volunteer_install
sh Install_step1.sh
```

#### 3.6 一度、EC2から抜ける
```
exit
```


## 4. 構築手順（後半）
### 4.1 EC2に入り直し、install後半を実行
```
sh connect.sh
cd micro_volunteer_install
sh Install_step2.sh
```


## 5. 完了
### 5.1 動作確認
以下のコマンドでサーバが起動していることを確認
```
curl -XGET http://localhost:8080/v1/hello
```
```{"result":"OK"}```が戻ってきたら、OK.
### 5.2 awsから抜ける
```
exit
```
