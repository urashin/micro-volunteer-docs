@echo off
mode con:COLS=150 LINES=30000
chcp 65001
setlocal enabledelayedexpansion

cd %~dp0
if exist %~dp0accesspoint.ini (
   echo 接続ツール_SSH
) else (
　 echo accesspoint.iniが存在しません。
   exit /b 1
)

for /f "tokens=1,* delims==" %%a in (%~dp0accesspoint.ini) do (
    set %%a=%%b
)
echo %DATE% %TIME% %COMPUTERNAME% %AWS_HOST%へ%USER_NAME%ユーザにて接続します。(%SSH_KEY%)

ssh -i %SSH_KEY% %USER_NAME%@%AWS_HOST%

echo %DATE% %TIME% %COMPUTERNAME% %AWS_HOST%（%USER_NAME%）より切断しました。

pause