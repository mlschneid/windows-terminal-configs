@echo off

REM This script to be called from the Windows Terminal profiles.json
REM In profiles.json, set "commandline" to something like "cmd.exe /k init.bat mylangconfig"
REM where `mylangconfig` is defined below.

set lang="%1"
set start_dir=%userprofile%\code
set code=%userprofile%\code

REM Set starting directory
cd %start_dir%

REM Set path env
set PATH=%PATH%;^
%userprofile%\bin\bin\;^
%userprofile%\bin\vendor\git-for-windows\usr\bin\;^
%code%\github.com\mlschneid\windows-terminal\vendor\ColorTool;

REM Set colorscheme
REM There seems to be a bug right now where you have to set the colorscheme
REM with -x and without before it sticks
colortool -q -x campbell.ini
colortool -q campbell.ini


REM Language specific configurations

REM C# 17
if %lang%=="csharp" (
    "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Tools\VsDevCmd.bat"
)

REM C# 19
if [%lang%]=="csharp19" (
    "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\Common7\Tools\VsDevCmd.bat"
)

REM Python 3.7
if [%lang%]=="python37" (
    set PATH="%PATH%";"%userprofile%"\AppData\Local\Programs\Python\Python37
)

REM WSL