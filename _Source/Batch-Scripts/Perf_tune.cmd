@echo off
setlocal EnableExtensions EnableDelayedExpansion
echo ==== APPLY PRESET %DATE% %TIME% ====>>"%LOG%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "try{Checkpoint-Computer -Description 'Apply_Perf_Preset' -RestorePointType 'MODIFY_SETTINGS' -ErrorAction SilentlyContinue}catch{}" >>"%LOG%" 2>&1
set Title=Apply Performance Preset (lean, VBS/HVCI off)
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit)
echo [*] Требуются права администратора...

:: 1) План питания: "Высокая производительность"
set powerschemetxt=%~dp0powerschemecurrent.txt
powercfg /getactivescheme>"%powerschemetxt%"
set /p PowerSchemeActive=<"%powerschemetxt%"
set PowerSchemeActiveCheck=%PowerSchemeActive:~-10,-4%
del /f /s /q "%powerschemetxt%"
Title %title% PowerSchemeActive = [%PowerSchemeActive%]

set "LOG=%~dp0\apply_perf_preset.log"
:: --- optional toggles ---
set "DISABLE_SYSMAIN=1"   :: 1 = вырубить SysMain (если даёт спайки I/O/CPU)
set "TOUCH_XBOX=1"        :: 1 = перевести Xbox-службы в Manual

:: --- create restore point (best effort) ---

echo [*] Отключаю VBS/HVCI/Hyper-V... >>"%LOG%"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f >>"%LOG%" 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f >>"%LOG%" 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LsaCfgFlags /t REG_DWORD /d 0 /f >>"%LOG%" 2>&1

bcdedit /set hypervisorlaunchtype off >>"%LOG%" 2>&1

dism /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart >>"%LOG%" 2>&1
dism /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-Hypervisor /NoRestart >>"%LOG%" 2>&1
dism /Online /Disable-Feature /FeatureName:VirtualMachinePlatform /NoRestart >>"%LOG%" 2>&1
dism /Online /Disable-Feature /FeatureName:HypervisorPlatform /NoRestart >>"%LOG%" 2>&1

echo [*] План питания и тайминги...  >>"%LOG%"
if "%PowerSchemeActiveCheck%"=="PowerX" (echo Вы уже используете подходящую схему питания: %PowerSchemeActiveCheck% >>"%LOG%" 2>&1) else (powercfg -setactive SCHEME_MIN >>"%LOG%" 2>&1)
::pause
:: CPU min/max on AC = 100/100
powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 893DEE8E-2BEF-41E0-89C6-B55D0929964C 100 >>"%LOG%" 2>&1
powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 BC5038F7-23E0-4960-96DA-33ABAF5935EC 100 >>"%LOG%" 2>&1

:: Unhide + max out core parking (минимум простаивающих ядер)
powercfg -attributes 54533251-82be-4824-96c1-47b60b740d00 0CC5B647-C1DF-4637-891A-DEC35C318583 -ATTRIB_HIDE >>"%LOG%" 2>&1
powercfg -setacvalueindex SCHEME_CURRENT 54533251-82be-4824-96c1-47b60b740d00 0CC5B647-C1DF-4637-891A-DEC35C318583 100 >>"%LOG%" 2>&1

:: PCIe ASPM = Off (меньше латентности на устройствах)
powercfg -setacvalueindex SCHEME_CURRENT 501A4D13-42AF-4429-9FD1-A8218C268E20 EE12F906-D277-404B-B6DA-E5FA1A576DF5 0 >>"%LOG%" 2>&1

echo [*] Графика/игровые: HAGS ON, GameDVR OFF, Game Mode ON...  >>"%LOG%"
reg add "HKLM\SYSTEM\CurrentControlSet\Control\GraphicsDrivers" /v HwSchMode /t REG_DWORD /d 2 /f >>"%LOG%" 2>&1

reg add "HKCU\Software\Microsoft\GameBar" /v AutoGameModeEnabled /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1
reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >>"%LOG%" 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >>"%LOG%" 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v ShowStartupPanel /t REG_DWORD /d 0 /f >>"%LOG%" 2>&1
if "%TOUCH_XBOX%"=="1" (
  echo [*] Xbox-службы -> Manual...  >>"%LOG%"
  for %%S in (XblAuthManager XblGameSave XboxNetApiSvc XboxGipSvc) do (
    sc stop %%S >>"%LOG%" 2>&1
    sc config %%S start= demand >>"%LOG%" 2>&1
  )
)

if "%DISABLE_SYSMAIN%"=="1" (
  echo [*] SysMain OFF...  >>"%LOG%"
  sc stop SysMain >>"%LOG%" 2>&1
  sc config SysMain start= disabled >>"%LOG%" 2>&1
)

echo [*] Storage Sense ON...  >>"%LOG%"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v 01 /t REG_DWORD /d 1 /f >>"%LOG%" 2>&1

powercfg -setactive SCHEME_CURRENT >>"%LOG%" 2>&1

echo.
echo [+] Накат выполнен. Рекомендуется перезагрузка.
echo [+] Накат выполнен. Рекомендуется перезагрузка. >>"%LOG%" 2>&1
echo     Лог: %LOG%
echo.
timeout /t 3 >nul
exit