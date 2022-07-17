@setlocal DisableDelayedExpansion
@echo off
::===============================================================================
set "SysPath=%SystemRoot%\System32"
if exist "%SystemRoot%\Sysnative\reg.exe" (set "SysPath=%SystemRoot%\Sysnative")
set "Path=%SysPath%;%SystemRoot%;%SysPath%\Wbem;%SysPath%\WindowsPowerShell\v1.0\"
set PATH=%PATH%;C:\Windows\System32;C:\Windows\SysWOW64\wbem;
::===============================================================================
::
::   This script has been created explicitly for Baboon's Workshop.
::   Discord Server: https://discord.gg/qRdVSkUW6n
::
::   Script has been written through the collaboration of monster & BadassBaboon
::
::   Credits to Law for sharing the method, and to Leeroy for finding the original version
::   method.
::
::===============================================================================
::========================================================================================================================================
setlocal EnableDelayedExpansion
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
::  Elevate script as admin and pass arguments and preventing loop
if exist %SystemRoot%\Sysnative\cmd.exe (
set "_cmdf=%~f0"
setlocal EnableDelayedExpansion
start %SystemRoot%\Sysnative\cmd.exe /c ""!_cmdf!" %*"
exit /b
)
::========================================================================================================================================
:: Re-launch the script with ARM32 process if it was initiated by x64 process on ARM64 Windows
if exist %SystemRoot%\SysArm32\cmd.exe if %PROCESSOR_ARCHITECTURE%==AMD64 (
set "_cmdf=%~f0"
setlocal EnableDelayedExpansion
start %SystemRoot%\SysArm32\cmd.exe /c ""!_cmdf!" %*"
exit /b
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

set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :_color %Red% "==== ERROR ====" &echo:"

%nul% reg query HKU\S-1-5-19 || (
if not defined _elev %nul% %_psc% "start cmd.exe -arg '/c \"!_PSarg:'=''!\"' -verb runas" && exit /b
%nceline%
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'.
goto RAGEOptEnd
)
::========================================================================================================================================
color 07
title RAGEMP Optimization Script - Launching
echo Terminating any other instance of RAGEMP prior to launching...
wmic process where name="updater.exe" delete >nul
wmic process where name="ragemp_v.exe" delete >nul
wmic process where name="tasklist.exe" delete >nul
wmic process where name="find.exe" delete >nul
wmic process where name="timeout.exe" delete >nul
echo Running updater.exe
cd..
start /w updater.exe
echo Deleting the EAC Certificates directory!
echo y|rmdir "./EasyAntiCheat/Certificates" /s /q
echo Setting pool overrides...
xcopy /s /y ".\fixes\pool_overrides_v.default.xml" ".\clientdata"
echo.
echo Please connect to the server now!
timeout /t 1 /nobreak > nul
echo We'll detect your game automatically as soon as it launches...
goto :LookforRAGE
::========================================================================================================================================
:LookforRAGE
tasklist|find "ragemp_game_ui"
IF %errorlevel% == 0 GOTO :FoundRAGE
timeout /t 5 /nobreak > nul
GOTO :LookforRAGE
::========================================================================================================================================
:FoundRAGE
echo.
echo RAGEMP found... Applying final optimizations... Please wait!
timeout /t 10 /nobreak > nul
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions"
if %errorlevel%==0 (
set _lock1=0
) else (
set _lock1=1
)
reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EACLauncher.exe\PerfOptions"
if %errorlevel%==0 (
set _lock2=0
) else (
set _lock2=1
)
if !_lock1!==0 (
  wmic process where name="ragemp_game_ui.exe" CALL setpriority "high priority"
  wmic process where name="PlayGTAV.exe" CALL setpriority "high priority"
  wmic process where name="Launcher.exe" CALL setpriority "high priority"
  wmic process where name="SocialClubHelper.exe" CALL setpriority "high priority"
) else ( echo Skipping process setting!)
net stop EasyAntiCheat_EOS
wmic process where name="EasyAntiCheat_EOS.exe" delete
echo.
echo Optimizations have been applied on your game!
goto :RAGEOptEnd
::========================================================================================================================================
:RAGEOptEnd
echo:
title You may now close this window!
echo Press any key to exit...
timeout /t 10
exit /b