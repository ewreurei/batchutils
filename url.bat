@echo off
setlocal
rem require: nkf(for Win), sd
rem なんとなくそれっぽくしようかと英語にしてみたけど、たぶん必要性は皆無....
rem argparse:
if "%~1"=="-d" (
	goto :decode
) else if "%~1"=="--decode" (
	goto :decode
) else if "%~1"=="-h" (
	goto :usage
) else if "%~1"=="--help" (
	goto :usage
) else if "%~1"=="" (
	goto :noargs
) else (
	goto :encode
)

:encode
	echo %*| nkf -wMQ | sd "=" "%%" | sd "%%\r\n" ""
	exit /b

:decode
	echo %*| sd "(-d|--decode)\s" "" | sd "%%" "=" | nkf -WmQ
	exit /b

:noargs
	rem エラー：引数にエンコードする文字列を指定してください
	rem 書式
	echo ERROR: Please specify encoding text from arguments
	echo Format:
	echo     url [-d^|--decode] ^<string^>
	echo/
	echo for more info, try `--help`
	exit /b

:usage
	echo Usage:
	echo     url [OPTION] ^<string^>
	echo Option:
	echo     -d, --decode   Decode string
	echo     -h, --help     Show this message
	exit /b
