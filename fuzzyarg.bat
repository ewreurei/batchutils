@echo off
for /f "usebackq delims=" %%i in (`%SELCMD%`) do ( %* %%i )
