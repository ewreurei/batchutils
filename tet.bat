@echo off
setlocal
rem tet - Minimum template expander (just a replacer)
rem require: sd. and this batchfile uses temp file
rem Example Usage:
rem   echo Hi, I'm {{ name }}. I'm learning about {{ thing }} now. > template.txt
rem   cat template.txt | tet name=John thing="vim settings"

set "tmpfile=%TEMP%\tet-%random%.tmp"
if "%~1"=="" ( echo Usage: %~n0 ^<variable^>=^<string^> & exit /b )

sd -s -- "{{ %~1 }}" "%~2" > "%tmpfile%"
call :loop %*

type "%tmpfile%" & del "%tmpfile%"
exit /b

:loop
	shift & shift
	if "%~2"=="" ( exit /b )
	rem in place modification is sd's default
	sd -s -- "{{ %~1 }}" "%~2" "%tmpfile%"
	goto :loop
