@echo off
setlocal
rem require: rhq, tr(sd), cut, any interactive filter tool(like fzf, peco, etc)
rem like unix shell image, cd $(rhq list | tr / \ | hs)

rem Example: [C:\Users\%USERNAME%\rhq\]github.com\user\repo
set rhqroot=%USERPROFILE%\rhq\
rem Example:  C:\Users\%USERNAME%\rhq\[github.com\user\repo]
set "cutfield=5-"
rem set selcmd=

for /f "usebackq delims=" %%i in (`rhq list ^| cut -d/ -f %cutfield% ^| tr / \ ^| %SELCMD% %*`) do ( set "dir=%%i" )
endlocal & if not "%dir%"=="" ( pushd %rhqroot%%dir% )
