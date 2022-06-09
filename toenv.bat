@echo off
rem USAGE:
rem   toenv var="cmd"
rem piped command:
rem   toenv var="cmd1 <args> ^| cmd2"

rem set "var=%~1"
rem set "cmd=%~2"
for /f "usebackq delims=" %%i in (`%~2`) do ( set "%~1=%%i" )
