@echo off
@setlocal DisableDelayedExpansion

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
set "SysPath=%SystemRoot%\System32"
if exist "%SystemRoot%\Sysnative\reg.exe" (set "SysPath=%SystemRoot%\Sysnative")
set "Path=%SysPath%;%SystemRoot%;%SysPath%\Wbem;%SysPath%\WindowsPowerShell\v1.0\"
set PATH=%PATH%;C:\Windows\System32;C:\Windows\SysWOW64\wbem;
::========================================================================================================================================
::  Fix for the special characters limitation in path name
set _NCS=1
call :_colorprep
set "nceline=echo: &echo ==== ERROR ==== &echo:"
set "eline=echo: &call :_color %Red% "==== ERROR ====" &echo:"
set _batf=%~f0
set _batp=%_batf:'=''%
set "_PSarg="""%~f0""" -el %_args%"
set _ttemp=%temp%
set PATH=%PATH%;C:\Windows\System32;C:\Windows\SysWOW64\wbem;
set "_psc=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
::========================================================================================================================================

::========================================================================================================================================
setlocal EnableDelayedExpansion
echo "!_batf!" | find /i "!_ttemp!" 1>nul && (
!nceline!
echo Script is launched from the temp folder,
echo Most likely you are running the script directly from the RAGEMP.zip archive.
echo:
echo Extract the archive contents to your RAGEMP installation directory then launch
echo the script again.
goto :RAGEOptEnd
)
::========================================================================================================================================

::========================================================================================================================================
::  Elevate script as admin and pass arguments and preventing loop
%nul% reg query HKU\S-1-5-19 || (
if not defined _elev %nul% %_psc% "start cmd.exe -arg '/c \"!_PSarg:'=''!\"' -verb runas" && exit /b
!nceline!
echo This script require administrator privileges.
echo To do so, right click on this script and select 'Run as administrator'.
goto :RAGEOptEnd
)
::========================================================================================================================================
:MainMenu
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
REM ============================================================== Game Priority Lock ============================================================
if !_lock1!==0 (set "_method1=%_Green% "    [Priority is currently High]"") else ( set "_method1=%_Yellow% "      [Priority is currently Normal]"")
if !_lock1!==0 (set _message1="               [1] Set RAGEMP Priority to Normal ") else (set _message1="               [1] Set RAGEMP Priority to High ")
REM ============================================================== EAC Priority Lock =============================================================
if !_lock2!==0 (set "_method2=%_Green% "    [Priority is currently Low]"") else ( set "_method2=%_Yellow% "      [Priority is currently Normal]"")
if !_lock2!==0 (set _message2="               [3] Set EACLauncher Priority to Normal ") else (set _message2="               [3] Set EACLauncher Priority to Low ")

color 07
title RAGEMP Optimization Script
mode 108, 39
echo:
echo:  _______________________________________________________________________________________________________
echo:       
echo:           This script has been created explicitly for Baboon's Workshop
echo:           Discord Server: https://discord.gg/qRdVSkUW6n
echo:           Credits go to Law for sharing the method and to Leeroy for finding the original method.
echo:       
echo:           Script Authors: monster and BadassBaboon
echo:  _______________________________________________________________________________________________________
echo:       
call :dk_color %_Red% "                 Game Priority Methods:"
echo:
call :dk_color2 %_White% !_message1! !_method1!
echo:               [2] Information on RAGEMP Priority
echo:        _______________________________________________________________________________
echo:       
call :dk_color %_Red% "                 Process Priority Methods:"
echo:
call :dk_color2 %_White% !_message2! !_method2!
echo:               [4] Information on EACLauncher Priority
echo:        _______________________________________________________________________________
echo:       
call :dk_color %_Red% "                 Launch Optimization Methods:"
echo:       
echo:               [5] Create Desktop Shortcut
echo:               [6] Information on Shortcut Creation
echo:        _______________________________________________________________________________   
echo:                                                                     
call :dk_color %_Red% "                 Miscellaneous:"
echo:
echo:               [7] Join Baboon's Workshop Discord Server
echo:               [8] Save changes and exit                 
echo:               [9] Finalize and launch
echo:        _______________________________________________________________________________   
echo:                                                                     
echo:               [U] Undo all changes and reset to default
echo:               [F] Frequently Asked Questions (FAQ)
echo:  _______________________________________________________________________________________________________
echo:
call :_color2 %_White% "         " %_Green% "Enter a menu option in the keyboard [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, R, X]: "
choice /C 123456789UF /N
set _erl=%errorlevel%

if %_erl%==11 setlocal & call :FAQ                                                                     & cls & endlocal & goto :MainMenu
if %_erl%==10 setlocal & call :UndoReset                                                               & cls & endlocal & goto :MainMenu
if %_erl%==9  setlocal & call :Finalize                                                                & cls & endlocal & goto :RAGEOptEnd
if %_erl%==8  exit
if %_erl%==7  start https://discord.gg/qRdVSkUW6n                                                                       & goto :MainMenu
if %_erl%==6  setlocal & call :ShortcutInformation                                                     & cls & endlocal & goto :MainMenu
if %_erl%==5  setlocal & call :CreateShortcut                                                          & cls & endlocal & goto :MainMenu
if %_erl%==4  setlocal & call :EACPInformation                                                         & cls & endlocal & goto :MainMenu
if %_erl%==3  setlocal & if !_lock2!==0 ( goto :EACPDeactivation) else ( goto :EACPActivation)         & cls & endlocal & goto :MainMenu
if %_erl%==2  setlocal & call :PriorityInformation                                                     & cls & endlocal & goto :MainMenu
if %_erl%==1  setlocal & if !_lock1!==0 ( goto :PriorityDeactivation) else ( goto :PriorityActivation) & cls & endlocal & goto :MainMenu
goto :MainMenu

::========================================================================================================================================
:PriorityActivation
echo Setting the game processes and sub-processes priority to high...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000003 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_game_ui.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000003 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PlayGTAV.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000003 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Launcher.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000003 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SocialClubHelper.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000003 /f
goto :MainMenu
::========================================================================================================================================
:PriorityDeactivation
echo Resetting the game processes and sub-processes priority back to normal...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_game_ui.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PlayGTAV.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Launcher.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SocialClubHelper.exe\PerfOptions" /f
goto :MainMenu
::========================================================================================================================================
:EACPActivation
echo Setting EACLauncher's priority to low...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EasyAntiCheat_EOS.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000001 /f
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EACLauncher.exe\PerfOptions" /t REG_DWORD /v CpuPriorityClass /d 00000001 /f
goto :MainMenu
::========================================================================================================================================
:EACPDeactivation
echo Setting EACLauncher's priority to normal...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EasyAntiCheat_EOS.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EACLauncher.exe\PerfOptions" /f
goto :MainMenu
::========================================================================================================================================
:PriorityInformation
mode 70, 23
title RAGEMP Optimization Script - Process Priority Information
echo.
echo  This method only requires a one-time setup, you can use it
echo  once and it'll reflect permanently until you change it again
echo  through the script.
echo.
call :dk_color %_Green% " High Priority:"
echo  Sets your main RAGEMP game process priority to high.
call :dk_color %_Red% " This method is only recommended if you have a modern CPU, "
call :dk_color %_Red% " otherwise, you might notice a completely opposite effect. " 
echo.
echo  The way the priority method works is setting a new priority
echo  of a process modifies its place in the processing queue. 
echo  Tasks with a higher priority are given preference in the allocation
echo  of system resources like CPU time and memory, allowing them to run
echo  faster with less stuttering or FPS drops.
echo:
call :dk_color %_Yellow% " Normal Priority:"
echo  This is the default priority and is recommended if you have an older
echo  CPU, or less than 16GB of RAM.
echo:
call :dk_color %_Yellow% " Press any key to go back..."
pause >nul
goto :MainMenu
::========================================================================================================================================
:UndoReset
echo Resetting the game's priority back to normal...
call :dk_color %_Red% " Errors in this section, if any, are normal. Do not panic!"
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_v.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\ragemp_game_ui.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\PlayGTAV.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\Launcher.exe\PerfOptions" /f
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\SocialClubHelper.exe\PerfOptions" /f
echo Resetting EAC's registry values to default...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EasyAntiCheat_EOS.exe\PerfOptions" /f >nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\EACLauncher.exe\PerfOptions" /f >nul
wmic process where name="ragemp_v.exe" delete >nul
echo Launching RAGEMP to verify your files' integrity...
start /w updater.exe
call :dk_color %_Blue% " All changes done by the script have been reset!"
call :dk_color %_Yellow% " Press any key to go back..."
pause >nul
goto :MainMenu
::========================================================================================================================================
:CreateShortcut
mode 70, 10
title RAGEMP Optimization Script - Shortcut Creation
set currentdirectory=%cd%
set _desktop_=
for /f "skip=2 tokens=2*" %%a in ('reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders" /v Desktop') do call set "_desktop_=%%b"
if not defined _desktop_ for /f "delims=" %%a in ('%_psc% "& {write-host $([Environment]::GetFolderPath('Desktop'))}"') do call set "_desktop_=%%a"
del "!_desktop_!\Rage Multiplayer.lnk"
!currentdirectory!\fixes\nircmd.exe shortcut "!currentdirectory!\fixes\launch_v2.bat" "~$folder.desktop$" "Rage Multiplayer" "" "!currentdirectory!\fixes\rage.ico" "" "" "!currentdirectory!" ""
if not exist "!_desktop_!\Rage Multiplayer.lnk" (
  echo Method 1 seems to have failed...
  echo Attempting alternative method?
  call "./fixes/shortcut.bat" -linkfile "!_desktop_!\Rage Multiplayer.lnk" -target "!currentdirectory!\fixes\launch_v2.bat" -adminpermissions yes -iconlocation "!currentdirectory!/fixes/rage.ico"
)
if not exist "!_desktop_!\Rage Multiplayer.lnk" (
  echo Shortcut creation failed... Report this on the Baboon's Workshop discord server.
)
echo.
echo  A shortcut has been created on your Desktop, please
echo  use it to launch the game from now on!
echo.
call :dk_color %_Yellow% "  Press any key to go back..."
pause >nul
goto :MainMenu
::========================================================================================================================================
:EACPInformation
mode 70, 17
title RAGEMP Optimization Script - EAC Priority Information
echo.
echo  This method only requires a one-time setup, you can use it
echo  once and it'll reflect permanently until you change it again
echo  through the script.
echo.
call :dk_color %_Green% " Low Priority:"
echo  Sets your EAC Launcher priority to low.
call :dk_color %_Green% " It's recommended to have this setting enabled on all systems, "
call :dk_color %_Green% " as it helps with allocating more resources to launching your game."
echo.
call :dk_color %_Yellow% " Normal Priority:"
echo  Sets your EAC Launcher priority back to normal, this is the
echo  default value.
echo:
call :dk_color %_Yellow% " Press any key to go back..."
pause >nul
goto :MainMenu
::========================================================================================================================================
:ShortcutInformation
mode 75, 13
title RAGEMP Optimization Script - Shortcut Creation Information
echo.
echo  This method only requires a one-time setup, you can use it
echo  once and it'll reflect permanently until you change it again
echo  through the script.
echo:
call :dk_color %_Green% " Desktop Shortcut:"
echo  Creates a desktop shortcut for the script to launch the RAGEMP launcher
echo  with the optimization directly.
call :dk_color %_Red% " This method is heavily recommended."
echo.
call :dk_color %_Yellow% " Press any key to go back..."
pause >nul
goto :MainMenu
::========================================================================================================================================
:Finalize
cls
title RAGEMP Optimization Script - Launching
echo Terminating any other instance of RAGEMP prior to launching...
wmic process where name="updater.exe" delete >nul
wmic process where name="ragemp_v.exe" delete >nul
wmic process where name="tasklist.exe" delete >nul
wmic process where name="find.exe" delete >nul
wmic process where name="timeout.exe" delete >nul
echo Running updater.exe
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
:FAQ
cls
mode 80, 28
title RAGEMP Optimization Script - Frequently Asked Questions
echo.
call :dk_color %_Yellow% " 1) What is this script?"
echo  This script is an implementation of a fully customized method that
echo  gives the user the option to completely choose the changes done to
echo  their game folder.
echo  - Faster loader times;
echo  - Restored the ability to use ENB and Reshade (with depth buffer enabled);
echo  - Combat texture loss (partially)
echo.
call :dk_color %_Yellow% " 2) Is this script safe to use?"
call :dk_color2 %_Green% " This script is completely safe to use" %_White% ", as it doesn't change any"
echo  vital files for EasyAntiCheat. It has been rigorously tested prior
echo  to release.
echo.
call :dk_color %_Yellow% " 3) What do I do if the CEF browser and chat starts lagging after"
call :dk_color %_Yellow% " using the script?"
echo  You can reset all changes done by the script in the menu by pressing
call :dk_color2 %_White% " the letter" %_Blue% " R"
echo.
call :dk_color %_Yellow% " 4) I have more questions, where do I ask?"
echo  You may ask in Baboon's Workshop discord server, where we've attached
echo  an automatic redirection link to the server.
call :dk_color2 %_White% " We ask you to use the " %_Red% "#support channel."
echo.
call :dk_color %_Yellow% " Press any key to go back to the main menu..."
pause >nul
goto :MainMenu
::========================================================================================================================================
:_color
if %_NCS% EQU 1 (
if defined _unattended ( echo %~2) else ( echo %esc%[%~1%~2%esc%[0m)
) else (
if defined _unattended (echo %~2) else (call :batcol %~1 "%~2")
)
exit /b
REM ========================================================================================================================================
:_color2
if %_NCS% EQU 1 (
echo %esc%[%~1%~2%esc%[%~3%~4%esc%[0m
) else (
call :batcol %~1 "%~2" %~3 "%~4"
)
exit /b
REM ========================================================================================================================================
:batcol
pushd %_coltemp%
if not exist "'" (<nul >"'" set /p "=.")
setlocal
set "s=%~2"
set "t=%~4"
call :_batcol %1 s %3 t
del /f /q "'"
del /f /q "`.txt"
popd
exit /b
REM ========================================================================================================================================
:_batcol
setlocal EnableDelayedExpansion
set "s=!%~2!"
set "t=!%~4!"
for /f delims^=^ eol^= %%i in ("!s!") do (
  if "!" equ "" setlocal DisableDelayedExpansion
    >`.txt (echo %%i\..\')
    findstr /a:%~1 /f:`.txt "."
    <nul set /p "=%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%"
)
if "%~4"=="" echo(&exit /b
setlocal EnableDelayedExpansion
for /f delims^=^ eol^= %%i in ("!t!") do (
  if "!" equ "" setlocal DisableDelayedExpansion
    >`.txt (echo %%i\..\')
    findstr /a:%~3 /f:`.txt "."
    <nul set /p "=%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%%_BS%"
)
echo(
exit /b
REM ========================================================================================================================================
:_colorprep
if %_NCS% EQU 1 (
for /F %%a in ('echo prompt $E ^| cmd') do set "esc=%%a"
set     "Red="41;97m""
set    "Gray="100;97m""
set   "Black="30m""
set   "Green="42;97m""
set    "Blue="44;97m""
set  "Yellow="43;97m""
set "Magenta="45;97m""
set    "_Red="40;91m""
set  "_Green="40;92m""
set   "_Blue="40;94m""
set  "_White="40;37m""
set "_Yellow="40;93m""
exit /b
)
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "_BS=%%A %%A"
set "_coltemp=%SystemRoot%\Temp"
set     "Red="CF""
set    "Gray="8F""
set   "Black="00""
set   "Green="2F""
set    "Blue="1F""
set  "Yellow="6F""
set "Magenta="5F""
set    "_Red="0C""
set  "_Green="0A""
set   "_Blue="09""
set  "_White="07""
set "_Yellow="0E""
exit /b
REM ========================================================================================================================================
:dk_color
echo %esc%[%~1%~2%esc%[0m
exit /b
REM ========================================================================================================================================
:dk_color2
echo !esc![%~1%~2%esc%[%~3%~4%esc%[0m
exit /b
REM ========================================================================================================================================
:dk_done
echo:
if %_unattended%==1 timeout /t 2 & exit /b
call :dk_color %_Yellow% "Press any key to %_exitmsg%..."
pause >nul
exit /b
REM ========================================================================================================================================
:RAGEOptEnd
echo:
title You may now close this window!
echo Press any key to exit...
timeout /t 10
exit /b