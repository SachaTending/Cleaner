:: Setup
@echo off
color 0c
chcp 65001
title OHR Cleaner
mode con: cols=120 lines=30
(Net session > nul 2>&1)||(PowerShell start %~0 -verb RunAs & Exit /B)
cd /d %~dp0

:: Start
echo.
echo                 ▒█████   ██░ ██  ██▀███      ▄████▄   ██▓    ▓█████ ▄▄▄       ███▄    █ ▓█████  ██▀███  
echo                ▒██▒  ██▒▓██░ ██▒▓██ ▒ ██▒   ▒██▀ ▀█  ▓██▒    ▓█   ▀▒████▄     ██ ▀█   █ ▓█   ▀ ▓██ ▒ ██▒
echo                ▒██░  ██▒▒██▀▀██░▓██ ░▄█ ▒   ▒▓█    ▄ ▒██░    ▒███  ▒██  ▀█▄  ▓██  ▀█ ██▒▒███   ▓██ ░▄█ ▒
echo                ▒██   ██░░▓█ ░██ ▒██▀▀█▄     ▒▓▓▄ ▄██▒▒██░    ▒▓█  ▄░██▄▄▄▄██ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██▀▀█▄  
echo                ░ ████▓▒░░▓█▒░██▓░██▓ ▒██▒   ▒ ▓███▀ ░░██████▒░▒████▒▓█   ▓██▒▒██░   ▓██░░▒████▒░██▓ ▒██▒
echo                ░ ▒░▒░▒░  ▒ ░░▒░▒░ ▒▓ ░▒▓░   ░ ░▒ ▒  ░░ ▒░▓  ░░░ ▒░ ░▒▒   ▓▒█░░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒▓ ░▒▓░
echo                  ░ ▒ ▒░  ▒ ░▒░ ░  ░▒ ░ ▒░     ░  ▒   ░ ░ ▒  ░ ░ ░  ░ ▒   ▒▒ ░░ ░░   ░ ▒░ ░ ░  ░  ░▒ ░ ▒░
echo                ░ ░ ░ ▒   ░  ░░ ░  ░░   ░    ░          ░ ░      ░    ░   ▒      ░   ░ ░    ░     ░░   ░ 
echo                    ░ ░   ░  ░  ░   ░        ░ ░          ░  ░   ░  ░     ░  ░         ░    ░  ░   ░     
echo                                             ░                                                           

timeout /t 1 > nul
echo.
echo Please don't close the cleaner during the cleaning process!

:: Stage 1
timeout /t 4 > nul
echo.
title OHR Cleaner ^| Stage 1
echo Stage 1 starting...

timeout /t 1 > nul
echo  - Creating cleaning process info file...
del info.txt > nul 2>&1
(
	echo OHR Cleaner Data
	echo.
	echo -- Free space before cleanup in C drive
	fsutil volume diskfree c:
	echo -- End
) > info.txt

timeout /t 1 > nul
echo  - Deleting old system restore points...
vssadmin delete shadows /all > nul 2>&1

timeout /t 1 > nul
echo  - Creating new system restore point...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "Automatic Restore Point", 100, 7 > nul 2>&1

echo Stage 1 completed!

:: Stage 2
timeout /t 1 > nul
echo.
title OHR Cleaner ^| Stage 2
echo Stage 2 starting...

timeout /t 1 > nul
echo  - Executing disk cleanup... (close it when it finishes)
cleanmgr /sagerun
cleanmgr /verylowdisk /c

timeout /t 1 > nul
echo  - Deleting temporary files...
del %LOCALAPPDATA%\FortniteGame\Saved\PersistentDownloadDir\ManifestCache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\"Epic Games"\"Epic Online Services"\"UI Helper"\Cache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\"Epic Games"\"Epic Online Services"\"UI Helper"\Logs\* /s /q > nul 2>&1
del %LOCALAPPDATA%\"Epic Games"\"Epic Online Services"\UserHelper\Logs\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Google\Chrome\"User Data"\GrShaderCache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\EpicGamesLauncher\Saved\webcache_4430\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Google\Chrome\"User Data"\ShaderCache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Google\DriveFS\cef_cache\Code Cache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Google\DriveFS\cef_cache\Cache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\CrashReportClient\Saved\Logs\* /s /q > nul 2>&1
del C:\Windows\SoftwareDistribution\Download\* /s /q > nul 2>&1
del %LOCALAPPDATA%\FortniteGame\Saved\Demos\* /s /q > nul 2>&1
del %LOCALAPPDATA%\"Epic Games"\EOSOverlay\* /s /q > nul 2>&1
del C:\Users\%USERNAME%\Videos\CacheClip\* /s /q > nul 2>&1
del C:\Users\%USERNAME%\Videos\.gallery\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Google\DriveFS\Logs\* /s /q > nul 2>&1
del %APPDATA%\Microsoft\Windows\Recent\* /s /q > nul 2>&1
del %PROGRAMDATA%\Roblox\Downloads\* /s /q > nul 2>&1
del %APPDATA%\.minecraft\webcache2\* /s /q > nul 2>&1
del %LOCALAPPDATA%\NVIDIA\DXCache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\NVIDIA\GLCache\* /s /q > nul 2>&1
del %APPDATA%\Exodus\"Code Cache"\* /s /q > nul 2>&1
del C:\Users\%USERNAME%\.cache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Roblox\logs\* /s /q > nul 2>&1
del %LOCALAPPDATA%\CrashDumps\* /s /q > nul 2>&1
del %APPDATA%\.minecraft\logs\* /s /q > nul 2>&1
del %LOCALAPPDATA%\D3DSCache\* /s /q > nul 2>&1
del %APPDATA%\Exodus\Cache\* /s /q > nul 2>&1
del %LOCALAPPDATA%\cache\* /s /q > nul 2>&1
del C:\Windows\Prefetch\* /s /q > nul 2>&1
del %LOCALAPPDATA%\Temp\* /s /q > nul 2>&1
del C:\Windows\Temp\* /s /q > nul 2>&1
del %TEMP%\* /s /q > nul 2>&1

timeout /t 1 > nul
echo  - Flushing Microsoft Store cache...
WSreset.exe

timeout /t 1 > nul
echo  - Flushing DNS Resolver cache...
ipconfig /flushdns > nul 2>&1

echo Stage 2 completed!

:: Stage 3
timeout /t 1 > nul
echo.
title OHR Cleaner ^| Stage 3
echo Stage 3 starting...

timeout /t 1 > nul
echo  - Saving cleaning process info...
(
	echo.
	echo -- Free space after cleanup in C drive
	fsutil volume diskfree c:
	echo -- End
	echo.
	echo -- Restore point information
	echo Name: Automatic Restore Point
	echo -- End
	echo.
	echo -- Credits
	echo Author: b8ff#0078
	echo YouTube: https://www.youtube.com/c/OHRTM
	echo Discord: https://discord.gg/BF8yG5S9FC
	echo -- End
) >> info.txt

echo Stage 3 completed!

:: End
timeout /t 2 > nul
echo.
title OHR Cleaner ^| Finished!
echo Cleaning process completed successfully!
echo Press any key to exit...

pause > nul
