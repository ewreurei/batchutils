@echo off
rem require: toenv, url, xq (jq), sd, rg
setlocal
if "%~1"=="" ( echo Usage: %~n0 ^<string^> & exit /b )
call toenv query="url %*"
rem curl "https://api.github.com/search/repositories?q=%query%" | xq -r ".items[].full_name"
curl -sSf "https://api.github.com/search/repositories?q=%query%" ^
	| xq -r ".items[] | .full_name, .description, []" | sd "^\[\]" "" | rg --color=always -e "^[^ ]*/[^ ]*" -e "^"
