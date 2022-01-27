@echo off
chcp 65001
setlocal enabledelayedexpansion

if exist %~dp0accesspoint.ini (
   echo 接続ツール_SCP
) else (
　 echo accesspoint.iniが存在しません。
   exit /b 1
)

for /f "tokens=1,* delims==" %%a in (%~dp0accesspoint.ini) do (
    set %%a=%%b
)

cd %~dp0

if exist %SEND_FILE% (
   echo 送付ファイルOK
) else (
　 echo 送付ファイルNG
   exit /b 2
)

echo %DATE% %TIME% %COMPUTERNAME% %AWS_HOST%へ%USER_NAME%ユーザにてコピーします。(%SSH_KEY%)

scp -i %SSH_KEY% %SEND_FILE% %USER_NAME%@%AWS_HOST%:~/

echo %DATE% %TIME% %COMPUTERNAME% %AWS_HOST%（%USER_NAME%）より切断しました。

pause