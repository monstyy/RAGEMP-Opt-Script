@echo off
setlocal enabledelayedexpansion
mode 70, 15
::========================================================================================================================
echo.
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
    echo Downloading the latest version from the github repository
    for /f "tokens=1,* delims=:" %%A in ('curl -ks https://api.github.com/repos/monstyy/RAGEMP-Opt-Script/releases/latest ^| find "browser_download_url"') do (
        curl -kOL %%B
        set url=%%B
        for %%a in ("%url%") do (
            set urlPath=!url:%%~NXa=!
            set urlName=%%~NXa
        )
        set _urlName=%urlName:"=%
        powershell Expand-Archive "%_urlName%" -destinationpath %cd% -force
        move /y ".\%_urlName%" ".\fixes\updates"
    )
)
::========================================================================================================================
pause