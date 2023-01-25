@echo off
setlocal

set file="%~1"
REM set "cmd=%*"
for /f "usebackq delims=" %%i in (`echo %*^| sd "%~1" "" ^| sd "^\s*--" ""`) do (set "cmd=%%i")
if not defined DIFFCMD (set "diffcmd=diff")

cat %file% | %cmd% | %DIFFCMD% %file% -
