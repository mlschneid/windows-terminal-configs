@echo off

set lang=%1
set start_dir=%userprofile%\code

cd %start_dir%

set code=%userprofile%\code

set PATH=%PATH%;^
%userprofile%\bin\bin\;^
%userprofile%\bin\vendor\git-for-windows\usr\bin\;^
%code%\github.com\mlschneid\windows-terminal\vendor\ColorTool;

REM Set colorscheme
REM There seems to be a bug right now where you have to set the colorscheme
REM with -x and without before it sticks
colortool -q -x campbell.ini
colortool -q campbell.ini

if [%lang%]==csharp (
    "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\Tools\VsDevCmd.bat"
)

if [%lang%]==csharp19 (
    "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview\Common7\Tools\VsDevCmd.bat"
)