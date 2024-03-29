@echo off
setlocal enabledelayedexpansion
rem Experimental and not perfect, intendedly
set "memodir=%MEMOBATDIR%"
rem set "selcmd=hs -s "%~2""
rem for CP932 environment:
set "selcmd=nkf -w ^| hs -s "%~2" ^| nkf"
set "previewcmd=cat"
set "grepcmd=rg"

if "%~1"=="new" (
	goto :new
) else if "%~1"=="list" (
	goto :list
) else if "%~1"=="edit" (
	goto :edit
) else if "%~1"=="grep" (
	goto :grep
) else if "%~1"=="cat" (
	goto :cat
) else (
	goto :usage
)

:new
	shift
	if "%~1"=="" (
		set /p title="Title: "
	) else (
		set "title=%~1%"
	)
	if "%title%"=="" ( exit /b )
	set "filepath=%memodir%\%date:/=-%-%title: =-%.md"
	type nul > %filepath%
	%EDITOR% %filepath%
	exit /b

:list
	dir /b %memodir%
	exit /b

:edit
	shift
	if not "%~1"=="" (
		set "arg=%~1"
		set "filepath=%memodir%\%date:/=-%-!arg: =-!.md"
	)
	if exist "%filepath%" (
		%EDITOR% "%filepath%"
	) else  (
		call :select "file"
		if not "!file!"=="" ( %EDITOR% "%memodir%\!file!" )
	)
	exit /b

:grep
	shift
	%grepcmd% %1 %memodir%
	exit /b

:cat
	shift
	if not "%~1"=="" (
		set "arg=%~1"
		set "filepath=%memodir%\%date:/=-%-!arg: =-!.md"
	)
	if exist "%filepath%" (
		%previewcmd% "%filepath%"
	) else (
		call :select "file"
		if not "!file!"=="" ( %previewcmd% "%memodir%\!file!" )
	)
	exit /b

:usage
	echo Usage:
	echo     %~n0 ^<Subcommand^>
	echo Subcommands:
	echo     new   create memo
	echo     list  listing memos
	echo     edit  edit memo
	echo     cat   see a memo
	echo     grep  grep in memos
	exit /b

rem Internal function
:select
	for /f "usebackq delims=" %%i in (`dir /b %memodir% ^| %selcmd%`) do (
		set "%~1=%%i"
	)
	exit /b

