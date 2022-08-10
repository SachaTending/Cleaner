:: Echo off / Title
@echo off
title OHR Cleaner ^| Created by b8ff

:: Ask for admin
if "%PROCESSOR_ARCHITECTURE%" equ "amd64" (
	> nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) else (
	> nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' neq '0' (
    echo Requesting admin privileges...
	timeout /t 2 > nul
    goto AskForAdmin
) else ( 
	goto Admin
)

:AskForAdmin
    echo set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:Admin
    pushd "%CD%"
    CD /D "%~dp0"

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
del c:\windows\prefetch\*.* /s /q > nul 2>&1
del c:\windows\softwaredistribution\download\*.*  /s /q > nul 2>&1

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
	echo Author: b8ff -^> OHR founder
	echo Discord: https://discord.gg/y6KcDSWtcy
	echo GitHub: https://github.com/b8ff
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
