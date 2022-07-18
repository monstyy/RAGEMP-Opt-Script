@echo off
set "SysPath=%SystemRoot%\System32"
if exist "%SystemRoot%\Sysnative\reg.exe" (set "SysPath=%SystemRoot%\Sysnative")
set "Path=%SysPath%;%SystemRoot%;%SysPath%\Wbem;%SysPath%\WindowsPowerShell\v1.0\"
set PATH=%PATH%;C:\Windows\System32;C:\Windows\SysWOW64\wbem;
del /q ".\fixes\*"
echo.
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