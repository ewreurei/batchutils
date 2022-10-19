@echo off
setlocal
rem require: xq (jq), teip, Heatseeker (hs)
if "%~1"=="" ( echo Usage: %~n0 ^<user^>/^<repo^> & exit /b )
rem  | rg "msvc|windows|amd|exe"
curl -sSf "https://api.github.com/repos/%~1/releases" | xq -r ".[0].assets[].browser_download_url" | teip -d/ -f 9 -- hs -s %~2 2>&1 | sd "^.* .*\n" "" | head -1
