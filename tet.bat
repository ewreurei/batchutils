@echo off
setlocal enabledelayedexpansion
rem tet - Minimum template expander (just a replacer)
rem require: sd. and this batchfile uses temp file
rem Example Usage:
rem   echo Hi, I'm {{ name }}. I'm learning about {{ thing }} now. > template.txt
rem   cat template.txt | tet name=John thing="vim settings"

set "tmpfile=%TEMP%\tet-%random%.tmp"
if "%~1"=="" ( echo Usage: %~n0 ^<variable^>=^<string^> & exit /b )

call :catchargs %*

sd -s "{{ %~1 }}" "%~2" > "%tmpfile%"
for /l %%i in (2,1,%num%) do (
	rem in place modification is sd's default
	sd -s "{{ !name[%%i]! }}" "!value[%%i]!" "%tmpfile%"
)

type "%tmpfile%" & del "%tmpfile%"
exit /b

:catchargs
	set "num=0"
	:loop
		set /a num+=1
		set "name[%num%]=%~1"
		set "value[%num%]=%~2"
		shift & shift
		if not "%~2"=="" ( goto :loop )	 
	exit /b
