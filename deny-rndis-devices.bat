:: Disable USB-RNDIS 
:: Rename service name in registry

@echo off
setlocal EnableDelayedExpansion
set REG_PATHS=HKLM\System\CurrentControlSet\Services

for /F %%i in ('reg query %REG_PATHS% ^| findstr /I usb*rndis') do (
	set REG_PATH=%%i
	if not "!REG_PATH:~-8!"=="disabled" (
		reg copy !REG_PATH! !REG_PATH!_disabled /s /f
		reg query !REG_PATH!_disabled && reg delete !REG_PATH! /f
	)
)


