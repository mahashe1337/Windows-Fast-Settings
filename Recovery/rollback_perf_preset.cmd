@echo off
setlocal EnableExtensions EnableDelayedExpansion
title Rollback Performance Preset (restore defaults, enable virtualization)

:: --- admin check ---

set "LOG=%SystemRoot%\Temp\rollback_perf_preset.log"
echo ==== ROLLBACK PRESET %DATE% %TIME% ====>>"%LOG%"

:: --- create restore point (best effort) ---
powershell -NoProfile -ExecutionPolicy Bypass -Command "try{Checkpoint-Computer -Description 'Rollback_Perf_Preset' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue}catch{}" >>"%LOG%" 2>&1

echo [*] Возвращаю VBS/HVCI/Hyper-V...  >>"%LOG%"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1
:: Если вы отключали Credential Guard:
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LsaCfgFlags /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1

bcdedit /set hypervisorlaunchtype auto >>"%LOG%" 2>&1

dism /Online /Enable-Feature /FeatureName:Microsoft-Hyper-V-All /All /NoRestart >>"%LOG%" 2>&1
dism /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /NoRestart >>"%LOG%" 2>&1
dism /Online /Enable-Feature /FeatureName:HypervisorPlatform /NoRestart >>"%LOG%" 2>&1

:: Re-hide core parking slider (возвращаем скрытый статус)
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 0CC5B647-C1DF-4637-891A-DEC35C318583 +ATTRIB_HIDE >>"%LOG%" 2>&1

echo [*] HAGS/игровые параметры -> дефолт...  >>"%LOG%"
:: Удаляем явное принуждение HAGS (пусть решает UI/драйвер)
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /f >>"%LOG%" 2>&1

:: Возвращаем запись экрана (если нужно по дефолту)
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v ShowStartupPanel /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1

echo [*] Storage Sense -> управляется системой...  >>"%LOG%"
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /f >>"%LOG%" 2>&1

:: Если вы отключали SysMain и хотите вернуть:
:: sc config SysMain start= auto
:: sc start SysMain

:: Xbox-службы - оставляем Manual (близко к дефолту на чистых системах)
:: При желании: sc config XblAuthManager start= demand / sc config XboxNetApiSvc start= demand ...

echo.
echo [+] Откат выполнен. Перезагрузка настоятельно рекомендуется.
echo     Лог: %LOG%
echo.
pause
exit /b 0
