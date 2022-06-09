@echo off
rem require: any interactive filter tool (like fuzzy finder)
rem `dhi rem` require: sd, rw

rem configure
set "dirsfile=%USERPROFILE%\dirs.txt"
rem Default is Heatseeker (that is replaceable, like `fzf` or `fzf --query`)
set "selcmd=hs -s"
rem set editor=

if "%~1"=="add" (
	goto :add
) else if "%~1"=="rm" (
	goto :remove
) else if "%~1"=="list" (
	goto :list
) else if "%~1"=="edit" (
	goto :edit
) else (
	goto :pushd
)
rem --- END ---

:pushd
	for /f "usebackq delims=" %%i in (`type "%dirsfile%" ^| %selcmd% %*`) do ( pushd "%%i" )
	exit /b

:add
	findstr /x "%cd%" "%dirsfile%" > NUL
	rem Equivalent to `||`, if not exist %cd% in file
	if "%errorlevel%"=="1" (
		cd >> "%dirsfile%"
		echo Added this dir
	)
	exit /b

:remove
	findstr /x "%cd%" "%dirsfile%" > NUL
	rem Equivalent to `&&`, if exist %cd% in file
	if "%errorlevel%"=="0" (
		sd -p %cd:\=\\%\r\n "" "%dirsfile%" | rw "%dirsfile%"
		echo Removed this dir
	)
	exit /b

:list
	type "%dirsfile%"
	exit /b

:edit
	%EDITOR% "%dirsfile%"
	exit /b
