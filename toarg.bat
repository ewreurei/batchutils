rem @echo off
setlocal
rem stdin to arg (for only one line)
rem if arugment is empty, just exec stdin as a command
set /p "stdin="
%* %stdin%
