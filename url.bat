@echo off
setlocal
rem require: nkf(for Win), sd
rem Ç»ÇÒÇ∆Ç»Ç≠ÇªÇÍÇ¡Ç€Ç≠ÇµÇÊÇ§Ç©Ç∆âpåÍÇ…ÇµÇƒÇ›ÇΩÇØÇ«ÅAÇΩÇ‘ÇÒïKóvê´ÇÕäFñ≥....
rem argparse:
if "%~1"=="-d" (
	goto :decode
) else if "%~1"=="--decode" (
	goto :decode
) else if "%~1"=="-h" (
	goto :usage
) else if "%~1"=="--help" (
	goto :usage
) else (
	goto :encode
)

:encode
	set "cmd=nkf -wMQ | sd "=" "%%" | sd "%%\r\n" """
	if "%~1"=="" (
		%cmd%
	) else if "%~1"=="-" (
		%cmd%
	) else (
		type "%~1"| %cmd%
	)
	exit /b

:decode
	rem set "cmd=sd "%%" "=" | nkf -WmQ"
	set "cmd=nkf --url-input"
	if "%~2"=="" (
		%cmd%
	) else if "%~2"=="-" (
		%cmd%
	) else (
		type "%~2"| %cmd%
	)
	exit /b

:usage
	echo Usage:
	echo     url [OPTION] [FILE]
	echo Option:
	echo     -d, --decode   Decode string
	echo     -h, --help     Show this message
	exit /b
