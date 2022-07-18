@setlocal DisableDelayedExpansion
@echo off

::===============================================================================
::
::   This script has been created explicitly for Baboon's Workshop.
::   Discord Server: https://discord.gg/qRdVSkUW6n
::
::   Script has been written through the collaboration of monster & BadassBaboon
::
::   Credits to Law for sharing the method, and to Leeroy for finding the original version
::   method
::
::===============================================================================
set "SysPath=%SystemRoot%\System32"
if exist "%SystemRoot%\Sysnative\reg.exe" (set "SysPath=%SystemRoot%\Sysnative")
set "Path=%SysPath%;%SystemRoot%;%SysPath%\Wbem;%SysPath%\WindowsPowerShell\v1.0\"
set PATH=%PATH%;C:\Windows\System32;C:\Windows\SysWOW64\wbem;
set "_batf=%~f0"
set "_batp=%_batf:'=''%"
set "_PSarg="""%~f0""" -el %_args%"
set "_ttemp=%temp%"
::========================================================================================================================================
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto :UACPrompt
) else ( goto :gotAdmin)
::========================================================================================================================================
:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    exit /B
::========================================================================================================================================
:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"
::========================================================================================================================================
if not exist .\updater.exe (
    echo This script needs to be placed in the RAGEMP root directory.
    echo Make sure that updater.exe exists in the same directory as the script.
    goto RAGEOptEnd
)
del .\start-rage.bat >nul
::========================================================================================================================================
if not exist .\fixes\main.bat (
    echo You didn't extract the script fully, you need to move the fixes folder to the root directory of RAGEMP.
    goto RAGEOptEnd
)
::========================================================================================================================================
reg delete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows Script Host\Settings" /v Enabled /f
reg add    "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows Script Host\Settings" /v Enabled /t REG_DWORD /d 1 /f
::========================================================================================================================================
::  Set Path variable, it helps if it is misconfigured in the system
set _elev=
if /i "%~1"=="-el" set _elev=1

set winbuild=1
set "nul=>nul 2>&1"
set "_psc=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
for /f "tokens=6 delims=[]. " %%G in ('ver') do set winbuild=%%G

set _NCS=1
if %winbuild% LSS 10586 set _NCS=0
if %winbuild% GEQ 10586 reg query "HKCU\Console" /v ForceV2 2>nul | find /i "0x0" 1>nul && (set _NCS=0)

::========================================================================================================================================
color 07
title RAGEMP Optimization Script
echo Checking for new script updates...
for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/monstyy/RAGEMP-Opt-Script/releases/latest ^| find "browser_download_url"') do (
    set url=%%B
)
::========================================================================================================================
for %%a in ("%url%") do (
   set urlPath=!url:%%~NXa=!
   set urlName=%%~NXa
)
set _urlName=%urlName:"=%
echo Latest version: %_urlName%
::========================================================================================================================
if exist .\fixes\updates\%_urlName% (
    echo Current version: %_urlName%
    echo You already have the latest version.
) else (
    xcopy /s /y ".\fixes\script-update.bat" ".\"
    start .\script-update.bat
    exit /b
)
::========================================================================================================================
call ./fixes/findPID.bat
taskkill /fi "PID ne %errorlevel%" /im cmd.exe /t /f
call ./fixes/main.bat
::========================================================================================================================================
:RAGEOptEnd
echo:
title You may now close this window!
echo Press any key to exit...
timeout /t 10
exit /b
