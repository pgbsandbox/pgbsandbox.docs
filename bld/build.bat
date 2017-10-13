@echo off
setlocal EnableDelayedExpansion

call :set_folder CURRENT_DIR .
if ERRORLEVEL 1 exit /B 1
call :set_folder SOURCE_DIR ..
if ERRORLEVEL 1 exit /B 1
call :set_folder OUTPUT_DIR ..\..\pgbsandbox.github.io
if ERRORLEVEL 1 exit /B 1
call :set_folder DITA_OTK_ROOT ..\..\..\dita-ot-2.5.3
if ERRORLEVEL 1 exit /B 1

set usage="USAGE: make.sh dev | rel"

if "%1"=="" (
    echo %usage%
    exit /B 1
)

if not "%2"=="" (
    echo %usage%
    exit /B 1
)

if not "%1"=="dev" (
   if not "%1"=="rel" (
    echo %usage%
    exit /B 1
    )
)
set mode=%1%

if exist "%OUTPUT_DIR%\js\edit.js" (
    set OUTPUT_DIR=%OUTPUT_DIR%\%mode%
) else (
    echo "%OUTPUT_DIR% is not a valid output destination."
    exit /B 1
)

rm -rf "%OUTPUT_DIR%"
cd "%DITA_OTK_ROOT%"
call bin\dita                                                                             ^
         --args.xhtml.contenttarget=contentwin                                            ^
         --args.xhtml.toc.xsl=plugins/com.stilo.authorbridge/xsl/map2xhtmltoc-wrapper.xsl ^
         --args.xhtml.toc=toc                                                             ^
         --args.css=AuthorBridge.css                                                      ^
         --args.cssroot="%SOURCE_DIR%/build_files"                                        ^
         --args.copycss=yes                                                               ^
         --args.input="%SOURCE_DIR%/DITA/AB.ditamap"                                      ^
         --output.dir="%OUTPUT_DIR%"                                                      ^
         --dita.temp.dir="%OUTPUT_DIR%/temp"                                              ^
         --transtype=xhtml                                                                ^
         --args.indexshow=no

xcopy "%SOURCE_DIR%"\build_files\* "%OUTPUT_DIR%" /y /q
cd %CURRENT_DIR%
GOTO :EOF


:set_folder
if exist "%2" (
   set f=%cd%
   pushd %2
   set %1=!cd!
   popd
   exit /B
) else (
   echo Invalid path: %2
   exit /B 1
)
goto:eof
