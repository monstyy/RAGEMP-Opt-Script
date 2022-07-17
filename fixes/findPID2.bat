@echo off
if not defined SESSIONNAME set SESSIONNAME=Console
setlocal
set instance=%DATE% %TIME% %RANDOM%
echo Instance: "%instance%"
title %instance%

for /f "usebackq tokens=2" %%a in (`tasklist /FO list /FI "SESSIONNAME eq %SESSIONNAME%" /FI "USERNAME eq %USERNAME%" /FI "WINDOWTITLE eq %instance%" ^| find /i "PID:"`) do set PID=%%a
if not defined PID for /f "usebackq tokens=2" %%a in (`tasklist /FO list /FI "SESSIONNAME eq %SESSIONNAME%" /FI "USERNAME eq %USERNAME%" /FI "WINDOWTITLE eq Administrator:  %instance%" ^| find /i "PID:"`) do set PID=%%a
if not defined PID echo !Error: Could not determine the Process ID of the current script.  Exiting.& exit /b 1

for /f "usebackq tokens=2*" %%a in (`tasklist /V /FO list /FI "PID eq %PID%" ^| find /i "Image Name:"`) do title %%b
endlocal & exit /b %PID%