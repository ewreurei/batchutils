@echo off
rem color grep using ripgrep
rem available color list: red, blue, green, cyan, magenta, yellow, white, black
if "%~2"=="" (
	echo ERROR: Argument is not enough, two arguments are required
	echo/
	goto :usage
)

rg --colors match:fg:%*
exit /b

:usage
	echo Grep with color specify in `rg --colors`
	echo Usage:
	echo     %~n0 ^<color^> ^<pattern^>
	echo Available color list:
	echo     red, blue, green, cyan, magenta, yellow, white and black
	exit /b
