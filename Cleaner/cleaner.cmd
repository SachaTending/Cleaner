:: Echo off / Title
@echo off
title OHR Cleaner ^| Created by b8ff

:: Ask for Admin
(Net session > nul 2>&1)||(PowerShell start """%~0""" -verb RunAs & Exit /B)

:: Start
title OHR Cleaner ^| Created by b8ff

echo Welcome to OHR Cleaner!

:: Important
timeout /t 2 > nul
echo.
echo Please don't close the cleaner during the cleaning process!

:: Stage 1
timeout /t 4 > nul
echo.
title OHR Cleaner ^| Created by b8ff ^| Stage 1
echo Stage 1 starting...

timeout /t 1 > nul
echo  - Creating cleaning process data file...
cd /D "%~dp0"
del data.txt > nul 2>&1
(
	echo OHR Cleaner Data
	echo.
	echo -- Free space before cleanup in C drive
	fsutil volume diskfree c:
	echo -- End
) > data.txt

echo Stage 1 completed!

:: Stage 2
timeout /t 2 > nul
echo.
title OHR Cleaner ^| Created by b8ff ^| Stage 2
echo Stage 2 starting...

timeout /t 1 > nul
echo  - Creating system restore point...
wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "OHR Cleaner", 100, 7 > nul 2>&1

echo Stage 2 completed!

:: Stage 3
timeout /t 2 > nul
echo.
title OHR Cleaner ^| Created by b8ff ^| Stage 3
echo Stage 3 starting...

timeout /t 1 > nul
echo  - Executing disk cleanup...
cleanmgr /sagerun
cleanmgr /verylowdisk /c

timeout /t 1 > nul
echo  - Deleting temporary files...
del %temp%\*.* /s /q > nul 2>&1
del C:\Windows\Prefetch\*.* /s /q > nul 2>&1
del C:\Windows\SoftwareDistribution\Download\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\Videos\CacheClip /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\NVIDIA\DXCache\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\NVIDIA\GLCache\*.* /s /q > nul 2>&1
del "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\GrShaderCache" /s /q > nul 2>&1
del "C:\Users\%USERNAME%\AppData\Local\Google\Chrome\User Data\ShaderCache" /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\DriveFS\Logs\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\DriveFS\cef_cache\Cache\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\Google\DriveFS\cef_cache\Code Cache\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\FortniteGame\Saved\Demos\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\FortniteGame\Saved\PersistentDownloadDir\ManifestCache\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\EpicGamesLauncher\Saved\webcache_4430 /s /q > nul 2>&1
del "C:\Users\%USERNAME%\AppData\Local\Epic Games\EOSOverlay" /s /q > nul 2>&1
del "C:\Users\%USERNAME%\AppData\Local\Epic Games\Epic Online Services\UI Helper\Cache" /s /q > nul 2>&1
del "C:\Users\%USERNAME%\AppData\Local\Epic Games\Epic Online Services\UI Helper\Logs" /s /q > nul 2>&1
del "C:\Users\%USERNAME%\AppData\Local\Epic Games\Epic Online Services\UserHelper\Logs" /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\CrashReportClient\Saved\Logs\*.* /s /q > nul 2>&1
del C:\Users\%USERNAME%\AppData\Local\cache /s /q > nul 2>&1

timeout /t 1 > nul
echo  - Deleting file explorer history...
del c:\users\%USERNAME%\appdata\roaming\microsoft\windows\recent\*.lnk /s /q > nul 2>&1

timeout /t 1 > nul
echo  - Flushing Microsoft Store cache...
WSreset.exe

timeout /t 1 > nul
echo  - Flushing DNS Resolver cache...
ipconfig /flushdns > nul 2>&1

echo Stage 3 completed!

:: Stage 4
timeout /t 2 > nul
echo.
title OHR Cleaner ^| Created by b8ff ^| Stage 4
echo Stage 4 starting...

timeout /t 1 > nul
echo  - Saving cleaning process data...
(
	echo.
	echo -- Free space after cleanup in C drive
	fsutil volume diskfree c:
	echo -- End
	echo.
	echo -- Restore point information
	echo Name: OHR Cleaner / Automatic Restore Point
	echo -- End
	echo.
	echo -- Credits
	echo Author: OHR - b8ff
	echo Discord: https://discord.gg/BF8yG5S9FC
	echo GitHub: https://github.com/b8ff
	echo YouTube: https://www.youtube.com/c/OHRTM
	echo PyPi: https://pypi.org/project/HexBear/
	echo -- End
) >> data.txt

timeout /t 1 > nul
echo  - Opening data file...
start data.txt

echo Stage 4 completed!

:: End
timeout /t 2 > nul
echo.
title OHR Cleaner ^| Created by b8ff
echo Cleaning process successfully completed!
echo Press any key to exit...

pause > nul
