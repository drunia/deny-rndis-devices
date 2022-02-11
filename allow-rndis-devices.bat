:: Allow USB-RNDIS 
:: Rename service name in registry

@echo off
setlocal EnableDelayedExpansion

:: Delete schedule
set TASK_NAME=deny-rndis-devices
schtasks /Delete /F /TN %TASK_NAME%

set REG_PATHS=HKLM\System\CurrentControlSet\Services
for /F %%i in ('reg query %REG_PATHS% ^| findstr /I /R usb.*rndis.*') do (
	set REG_PATH=%%i
	if "!REG_PATH:~-8!"=="disabled" (
		reg copy !REG_PATH! !REG_PATH:~0,-9!  /s /f
		reg query !REG_PATH:~0,-9! && reg delete !REG_PATH! /f
	)
)

set /a ERRORLEVEL=0
exit

