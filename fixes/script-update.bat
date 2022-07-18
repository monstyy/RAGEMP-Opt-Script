@echo off
del /q ".\fixes\*"
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
    echo Script has been updated... Launch rage-setup.bat again.
    timeout /t 5
    (goto) 2>nul & del "%~f0"
    exit
)