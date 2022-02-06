# awsにmicro-volunteer環境構築を行う方法(Windowsの場合)
管理者権限ユーザにてGit For WindowsをインストールすることでMacと同等環境を構築する。

##　1.Git For Windowsダウンロード
### 1.1.GitForWindows公式ページへアクセス
```
https://gitforwindows.org/
```
### 1.2.GitForWindowsのダウンロード
->Downloadを選択。
ダウンロードフォルダーにダウンロードされたことを確認。
（ファイル名の例）Git-2.35.1.2-64-bit.exe

##　2.Git For Windowsのインストール・起動
### 2.1.インストーラ実行・Informaiton画面
　Git-2.35.1.2-64-bit.exeを実行し、そのままNext
### 2.2.Selecr Destination Location
　C:\Program Files\GitのままNext
### 2.3.Select Components
　変更せずNext
### 2.4.Select Start Menu Folder
　GitのままNext
### 2.5.Choosing the default editor used by Git 
　Use Vim (the ubiquitous text editor) as Git's default editorのままNext
### 2.6.Adjusting the name of the initial branch in new reppositories 
　Let Git DecideのままNext
### 2.7.Adjusting your PATH environment 
　Use Git from Git Bash onlyに変更してNext
### 2.8.Choosing the SSH executable 
　Use bundled OpenSSH NextのままNext
### 2.9.Choosing HTTPS transport backend 
　Use the OpenSSL libraryのままNext
### 2.10.Configuring the line ending conversions 
　Checkout Windows-style, commit Unix-style line endingsのままNext

### 2.11.Configuring the terminal emulator to use with Git Bash
　Use MinTTY (the default terminal of MSYS2)のままNext
### 2.12.Chose the default bahavior of `git pull`
　Default(fast-forward or merge)のままNext
### 2.13.Choose a credential hepler 
　Git Credential Manager

### 2.14.Configuring extra options
　Enable file system cacheing
　Enable symbolic links
　にチェックを入れて、Next

### 2.15.Configuring experimental options
　Install

### 2.16.Completing the Git Setup Wizard
　Finish

### 2.17.Git For WIndows の起動
　スタート->Git->Git Bashを選択。
### 2.18.デスクトップ上にカレントディレクトリを移動。
  cd Desktop


以降はMACの構築手順3.以降を実施してください。

なお、管理者権限が使えない場合を想定して、awsにInstallerをコピーまで代行してもらえれば
以降はsshConnect.batを使用して作業再開できる。

同階層上にsshConnect.bat、accesspoint.iniとSSH鍵を配置。
accesspoint.iniのSSH_KEYをSSH鍵のファイル名、AWS_HOSTを接続先のAWSホスト名へ書き換え。
sshConnect.batを実行すると、AWSへ接続できる。
