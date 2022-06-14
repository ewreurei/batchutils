@echo off
setlocal
if "%~1"=="" ( echo Usage: %~n0 ^<string^> & exit /b )
call toenv query="url %*"
curl "https://correct-jp.vercel.app/api/raw/%query%"
