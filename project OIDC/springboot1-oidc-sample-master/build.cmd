@ECHO OFF

set REPO=reg-dhc-americas.app.corpintra.net/nggarage/springboot-oidc
set TAG=1.5.19
set VERSION=

REM echo Using %REPO%:%TAG%
IF [%1] == [] (
  echo version number must be specified
  exit 1
)
set VERSION=%1

set IMAGE=%REPO%:%TAG%-%VERSION%
echo Image name = %IMAGE%
docker inspect %IMAGE% >nul 2>&1
REM echo %errorlevel%
if %errorlevel% equ 0 (
  echo Image %IMAGE% already exists
  exit
)

docker build -t %IMAGE% .
