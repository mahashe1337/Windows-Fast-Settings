:: 1) Выключить VBS
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard" /v EnableVirtualizationBasedSecurity /t REG_DWORD /d 0 /f

:: 2) Выключить HVCI (Memory Integrity)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\DeviceGuard\Scenarios\HypervisorEnforcedCodeIntegrity" /v Enabled /t REG_DWORD /d 0 /f

:: (Опционально) Выключить Credential Guard, если включён политикой
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Lsa" /v LsaCfgFlags /t REG_DWORD /d 0 /f

:: 3) Отключить гипервизор на уровне загрузчика
bcdedit /set hypervisorlaunchtype off

:: 4) Убрать фичи гипервизора (чтобы их автоперезапуск не включил всё обратно)
dism /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-All /NoRestart
dism /Online /Disable-Feature /FeatureName:Microsoft-Hyper-V-Hypervisor /NoRestart
dism /Online /Disable-Feature /FeatureName:VirtualMachinePlatform /NoRestart
dism /Online /Disable-Feature /FeatureName:HypervisorPlatform /NoRestart

:: 5) Перезагрузка