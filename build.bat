@echo off

set NAME=HackTech
set PATH="C:\Program Files\7-Zip"
set LOVEPATH="C:\Program Files\LOVE"
set DBPATH=E:\Dropbox\Public\Temp

mkdir bin
7z a -tzip %NAME%.love *.lua Data DGL GUI HackTech Lib %NAME%
copy /b %LOVEPATH%\love.exe+%NAME%.love bin\%NAME%.exe
copy /b %LOVEPATH%\*.dll bin
del %NAME%.love

cd bin
7z a %NAME%.7z *.*
copy /Y %NAME%.7z %DBPATH%
del %NAME%.7z

rem pause >nul
