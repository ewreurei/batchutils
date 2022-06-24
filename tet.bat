@echo off
setlocal
rem tet - Minimum template expander (just a replacer)
rem require: sd
rem Example Usage:
rem   echo Hi, I'm {{ name }}. I'm learning about {{ thing }} now. > template.txt
rem   cat template.txt | tet name=John thing="vim settings"

if "%~1"=="" ( echo Usage: %~n0 ^<variable^>=^<string^> & exit /b )

set "cmd=sd -s -- "{{ %~1 }}" "%~2""
call :loop %*
%cmd%
exit /b

:loop
	shift & shift
	if "%~2"=="" ( exit /b )
	set "cmd=%cmd% | sd -s -- "{{ %~1 }}" "%~2""
	goto :loop
