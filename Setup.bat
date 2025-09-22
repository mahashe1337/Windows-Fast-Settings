@echo off
if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin &&exit)
mode con:cols=171 lines=33
cls
set DebugMode=Deactive
set TitleHeader=Оптимизация Windows By Mahashe Version 2.6:
set TitleMessage=MahasheTweak:
set Backup=%~dp0%Username%_Backup
set UtilityDir=%~dp0_Source\Utilityes
set BatchsrcDir=%~dp0_Source\Batch-Scripts
set TextColor=06

set DefaultTelegramDirectory=D:\Apps\Telegram
set tg-fix=%~dp0_Source\Registry-Settings\tg.fix.reg
set Root=%UtilityDir%\PowerRun.exe
set nColor=%UtilityDir%\nhcolor.exe
set winfix=%~dp0_Source\LauncherWinFix.bat
C:\Windows\System32\reg.exe add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" /f /v "SystemRestorePointCreationFrequency" /t REG_DWORD /d "60"
:: Настройки
goto Tg-Action
goto Backup_regedit

:ApplyChanged
Title %TitleHeader% Применение быстрых твиков для Windows
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo %TitleMessage% Применение твиков реестра |"%nColor%" %TextColor%
C:\Windows\regedit.exe -s "%~dp0_Source\Registry-Settings\RegistryTweaks.reg"
C:\Windows\regedit.exe -s "%~dp0_Source\Registry-Settings\Add_Take_Ownership_to_context_menu.reg"
C:\Windows\regedit.exe -s "%~dp0_Source\Registry-Settings\[+]RecycleBin.reg"

if "%DebugMode%"=="Active" (start "" "%BatchsrcDir%\Diagnostic_Service[+].bat"&&pause) else (start /min "" "%BatchsrcDir%\Diagnostic_Service[+].bat")
if "%DebugMode%"=="Active" (start "" "%BatchsrcDir%\VBS-HyperVisor-Protected-Code-Integrity-Disabled.bat"&&pause) else (start /min "" "%BatchsrcDir%\VBS-HyperVisor-Protected-Code-Integrity-Disabled.bat")
if "%DebugMode%"=="Active" (start "" "%BatchsrcDir%\OneDrive-Lock.cmd"&&pause) else (start /min "" "%BatchsrcDir%\OneDrive-Lock.cmd")
if "%DebugMode%"=="Active" (start "" "%BatchsrcDir%\Windows-Update-Download-Drivers-Disabled.cmd"&&pause) else (start /min "" "%BatchsrcDir%\Windows-Update-Download-Drivers-Disabled.cmd")
if "%DebugMode%"=="Active" (start /wait "" "%BatchsrcDir%\Remove-Microsoft-Edge.bat"&&pause) else (start /wait /min "" "%BatchsrcDir%\Remove-Microsoft-Edge.bat")

Powershell -command "Add-LocalGroupMember -Group Администраторы -Member $env:USERNAME"
start /wait "" "%BatchsrcDir%\Exe\AddMeAdminsGroup.exe"

copy /y "%~dp0User-System-CopyFiles\*.*" "C:\Windows"
timeout /t 2 >nul

:Настройка_Windows
Title %TitleHeader% Применений настроек для Windows
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo %TitleMessage% Настройка виндовс: |"%nColor%" %TextColor%
taskkill /f /im "explorer.exe" >nul
echo %TitleMessage% Настройка реестра применение таких твиков как: |"%nColor%" %TextColor%
echo Очистка папок из этого компьютера[проводник раздел папки рядом с дисками]. |"%nColor%" %TextColor%
echo Отключение BiLocker |"%nColor%" %TextColor%
echo Добавление схемы электропитания Максимальная производительность |"%nColor%" %TextColor%
echo Отключение предупреждений в PowerShell |"%nColor%" %TextColor%
echo Блокировка запуска файла Narrator.exe |"%nColor%" %TextColor%
echo Отключение экранной клавиатуры |"%nColor%" %TextColor%
echo.
echo.
timeout /t 4 >nul
echo %TitleMessage% Удаление папок из "Этот компьютер" |"%nColor%" %TextColor%
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /F
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /F
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /F
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /F
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /F
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /F
C:\Windows\System32\reg.exe delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /F
start /wait "" "%BatchsrcDir%\Exe\ComputerDirectoryClean.exe"
taskkill /f /im "explorer.exe" >nul
echo %TitleMessage% Отключение драйвера службы BitLocker |"%nColor%" %TextColor%
C:\Windows\System32\sc.exe stop BDESVC
C:\Windows\System32\sc.exe config BDESVC start= disabled

echo %TitleMessage% Отключение других связанных компонентов |"%nColor%" %TextColor%
C:\Windows\System32\reg.exe add "HKLM\System\CurrentControlSet\Control\BitLocker" /v "EnableBDE" /t REG_DWORD /d 0 /f
C:\Windows\System32\reg.exe add "HKLM\System\CurrentControlSet\Control\BitLocker" /v "EnableTPM" /t REG_DWORD /d 0 /f
C:\Windows\System32\bcdedit.exe /set {default} bootstatuspolicy ignoreallfailures

C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command "Set-ExecutionPolicy -Scope LocalMachine RemoteSigned -Force"
if "%DebugMode%"=="Active" (start "" "%BatchsrcDir%\Perf_tune.cmd"&&pause) else (start /min "" "%BatchsrcDir%\Perf_tune.cmd")
::reg add "HKCU\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d RemoteSigned /f
::reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d RemoteSigned /f
::reg add "HKCU\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d RemoteSigned /f
::reg add "HKLM\SOFTWARE\Microsoft\PowerShell\7\ShellIds\Microsoft.PowerShell" /v ExecutionPolicy /t REG_SZ /d RemoteSigned /f
timeout /t 5 >Nul
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo.
echo %TitleMessage% Блокировка запуска процесса: Narrator.exe |"%nColor%" %TextColor%
timeout /t 2 >nul
C:\Windows\System32\reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /f&&C:\Windows\System32\reg.exe add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun" /f /v "%random%" /t REG_SZ /d "Narrator.exe"
echo %TitleMessage% Отключение экранной клавиатуры |"%nColor%" %TextColor%
taskkill /im osk.exe /f 2>nul
taskkill /im TabTip.exe /f 2>nul
taskkill /im TextInputHost.exe /f 2>nul
sc config TabletInputService start=disabled
sc stop TabletInputService >nul
if "%DebugMode%"=="Active" (pause) else (set NotSpace=%random%)
::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами
::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами
::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами::::::::::::::::::::::::::::::::Настройка_Утилитами
Title %TitleHeader% Настройка Windows с использованием готовых скриптов и утилит
:Defender-remover-Launch
echo %TitleMessage% Ожидание завершения работы: Defender Remover [Отключение Windows Defender] |"%nColor%" %TextColor%
"%Root%" "%UtilityDir%\DefenderRemover.exe"
set "PROC=DefenderRemover.exe" & set /a T=600
timeout /t 3 >nul
:DefenderRemoverLoop
tasklist /fi "imagename eq %PROC%" | find /i "%PROC%" >nul || (shutdown /a >nul 2>&1 & goto NextCode)
set /a T-=1 & if %T% leq 0 (taskkill /im %PROC% /t /f >nul 2>&1 & shutdown /a >nul 2>&1 & goto NextCode) & timeout /t 1 /nobreak >nul & goto DefenderRemoverLoop
::for /F %%i in ('tasklist /FI "IMAGENAME eq DefenderRemover.exe" ^| find /i /C "DefenderRemover.exe"') do (if "%%i" == "0" (cls&&shutdown /a&&goto UnParkControl)) - Старая версия кода
goto DefenderRemoverLoop



:NextCode
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo Скрипт: Отключение и настройка задач в планировщике задач от имени системы |"%nColor%" %TextColor%
"%Root%" "%BatchsrcDir%\TaskShedullerOptimizate.bat"

echo Скрипт: Hyper V Control |"%nColor%" %TextColor%
start /wait "" "%BatchsrcDir%\HyperVDisableEnable-v1.0.0.cmd"
Title %TitleHeader% Пара вопросов по настройке Windows к пользователю


:Registry-settings
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo "Применить дополнительные настройки реестра?" |"%nColor%" %TextColor%&&echo Изменения применяемые этим файлом можно посмотреть по пути: [%~dp0\_Source\Registry-Settings\ChangeList-AutoMateApplyRegistry.txt] |"%nColor%" %TextColor%&&echo.&&echo [01] - Применить |"%nColor%" %TextColor%&&echo [02] - Пропустить эту настройку |"%nColor%" %TextColor%&&echo.
set /p answer=" :>   "
if /i "%answer%"=="1" C:\Windows\regedit.exe -s "%~dp0_Source\Registry-Settings\RegistryTweaks_AutomateApply.reg"&&goto Default_Apps_remover
if /i "%answer%"=="2" goto Default_Apps_remover
goto Registry-settings
:Default_Apps_remover
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo "Запустить удаление предустановленных программ виндовс?" |"%nColor%" %TextColor%&&echo.&&echo [01] - Запустить стандартный скрипт |"%nColor%" %TextColor%&&echo [02] - Запустить расширенный Powershell скрипт [English] |"%nColor%" %TextColor%&&echo [03] - Пропустить эту настройку |"%nColor%" %TextColor%&&echo.
set /p answer=" :>   "
if /i "%answer%"=="1" echo Скрипт: Default Apps Remover |"%nColor%" %TextColor%&&start /wait "" "%UtilityDir%\PreInstall_Apps_Removers\DefaultAppsRemover.exe"&&goto Printer-Setting
if /i "%answer%"=="2" cls&&echo Скрипт: remove preinstalled apps |"%nColor%" %TextColor%&&powershell -NoProfile -ExecutionPolicy Bypass -File "%UtilityDir%\PreInstall_Apps_Removers\remove_preinstalled_apps.ps1"&&goto Printer-Setting
if /i "%answer%"=="3" goto Printer-Setting
goto Default_Apps_remover
:Printer-Setting
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo "Запустить программу для отключения принтера в Windows?" |"%nColor%" %TextColor%&&echo.&&echo [01] - Запустить |"%nColor%" %TextColor%&&echo [02] - Пропустить эту настройку |"%nColor%" %TextColor%&&echo.
set /p answer=" :>   "
if /i "%answer%"=="1" echo Скрипт: Printer Disable |"%nColor%" %TextColor%&&start "" "%BatchsrcDir%\AutoMate-Scripts\Printer-Off.cmd"&&goto _Zapret-Install
if /i "%answer%"=="2" goto _Zapret-Install
goto Printer-Setting
:_Zapret-Install
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo "Установить скрипт Zapret в Windows?"&&echo.&&echo [01] - Установить&&echo [02] - Пропустить эту настройку&&echo.
set /p answer=" :>   "
if /i "%answer%"=="1" echo Скрипт: _Zapret-Install |"%nColor%" %TextColor%&&start /wait /min "" "%~dp0Приложения\Zapret\Install-Zapret.bat"&&goto tg-quest
if /i "%answer%"=="2" goto tg-quest
goto _Zapret-Install
:tg-quest
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo Telegram Fix. Фикс ссылок t:me\\ |"%nColor%" %TextColor%&&echo.
if exist "%DefaultTelegramDirectory%" (echo Telegram Directory: %DefaultTelegramDirectory% - Найден |"%nColor%" %TextColor%) else (echo Telegram Directory: %DefaultTelegramDirectory% - Не найден |"%nColor%" %TextColor%)
if exist "%tg-fix%" (echo Telegram Fix File: Найден [%tg-fix%] |"%nColor%" %TextColor%) else (echo Telegram Fix File: Не найден [%tg-fix%] |"%nColor%" %TextColor%)
echo.&&echo [01] Применить стандартный рег файл с использованием пути: D:\Apps\Telegram\Telegram.exe |"%nColor%" %TextColor%&&echo [02] Указать путь до telegram.exe |"%nColor%" %TextColor%&&echo [03] Не применять |"%nColor%" %TextColor%&&echo.
set /p answer=" :>   "
if /i "%answer%"=="1" if exist "%tg-fix%" (regedit.exe -s "%tg-fix%"&&msg * tg-fix Применен.&&goto Admin-quest) else (echo %tg-fix% - Не найден&&pause)
if /i "%answer%"=="2" goto Tg-Action
if /i "%answer%"=="3" goto Admin-quest
goto tg-quest
:Tg-Action
setlocal EnableDelayedExpansion
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo Укажите путь вида: D:\Apps\Telegram\Telegram.exe |"%nColor%" %TextColor%
set /p telegrampath=" :>   "
rem экранирование бэкслешей без FOR
set "escaped=!telegrampath:\=\\!"

rem регистрация протокола tg://
reg add "HKCR\tg" /ve /d "URL:Telegram Link" /f
reg add "HKCR\tg" /v "URL Protocol" /t REG_SZ /d "" /f
reg add "HKCR\tg\DefaultIcon" /ve /d "\"!escaped!,1\"" /f
reg add "HKCR\tg\shell\open\command" /ve /d "\"!escaped!\" -- \"%%1\"" /f
msg * MahasheTweakSetup: Telegram Url Fix Применен.
goto Admin-quest


:Admin-quest
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo Windows Fix [Не рекомендуется, оставлен на случай если все заебало] |"%nColor%" %TextColor%&&echo.&&echo Применяет скрипт для разблокировки доступа в реестр больше не будет проблем с доступом в реестр |"%nColor%" %TextColor%&&echo.&&echo [01] Применить |"%nColor%" %TextColor%&&echo [02] Не применять |"%nColor%" %TextColor%&&echo.
set /p answer=" :>   "
if /i "%answer%"=="1" if exist "%winfix%" (start "" "%winfix%"&&msg * Win-fix Применяется.&&goto PostEnd) else (echo %winfix% - Не найден |"%nColor%" %TextColor%&&pause&&goto PostEnd)
if /i "%answer%"=="2" goto PostEnd
goto Admin-quest


:PostEnd
Title %TitleHeader% Запуск завершающих быстрых команд
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo %TitleMessage% Запуск завершающих быстрых команд |"%nColor%" %TextColor%&&echo сброс кеша настроек интернета |"%nColor%" %TextColor%
C:\Windows\System32\ipconfig.exe /flushdns
C:\Windows\System32\netsh.exe winsock reset
C:\Windows\System32\netsh.exe int ip reset
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo %TitleMessage% Ожидание перед очисткой системы. |"%nColor%" %TextColor%&&echo %TitleMessage% 5 sec |"%nColor%" %TextColor%
timeout /t 5 >nul
echo %TitleMessage% быстрая очистка системы\Выберите действие [не связанное с очисткой системы] |"%nColor%" %TextColor%
%Root% "%BatchsrcDir%\Clean.bat"
"%Root%" "%BatchsrcDir%\Clean.bat"
echo Нажмите Enter для перезагрузки explorer |"%nColor%" %TextColor%&&echo.&&pause
taskkill /f /im "explorer.exe" >nul
timeout /t 3 >nul
start "" "explorer.exe"
if "%DebugMode%"=="Active" (set NotSpace=%random%) else (cls)
echo Нажмите Enter для перезагрузки Windows |"%nColor%" %TextColor%&&echo.&&pause
shutdown /r /t 30
timeout /t 2 >nul
exit












:Backup_regedit
echo %TitleMessage% Создание точки восстановления: |"%nColor%" %TextColor%
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe "Checkpoint-Computer -Description "AutoBackup_Author_Mahashe_%Date%" -RestorePointType "MODIFY_SETTINGS""
if exist "%Backup%" (echo %TitleMessage% Сохранение уже было произведено, возврат... |"%nColor%" %TextColor%&&timeout /t 3 >nul&&goto ApplyChanged) else (echo %TitleMessage% Сохранение прежних настроек реестра: |"%nColor%" %TextColor%&&mkdir "%Backup%")
C:\Windows\System32\reg.exe export "HKEY_CURRENT_USER" "%Backup%\HKEY_CURRENT_USER.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE" "%Backup%\HKEY_LOCAL_MACHINE.reg" /y

C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\mouclass\Parameters" "%Backup%\mouclass.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\kbdclass\Parameters" "%Backup%\kbdclass.reg" /y
C:\Windows\System32\reg.exe export "HKEY_CURRENT_USER\Control Panel\Accessibility" "%Backup%\Accessibility.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl" "%Backup%\PriorityControl.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" "%Backup%\Memory_Management.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Kernel" "%Backup%\Kernel.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching" "%Backup%\DriverSearching.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate" "%Backup%\WindowsUpdate.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power" "%Backup%\Power.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "%Backup%\SystemProfile.reg" /y
C:\Windows\System32\reg.exe export "HKEY_CURRENT_USER\System\GameConfigStore" "%Backup%\GameConfigStore.reg" /y
C:\Windows\System32\reg.exe export "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR" "%Backup%\AllowGameDVR.reg" /y
C:\Windows\System32\reg.exe export "HKEY_CURRENT_USER\Control Panel\Mouse" "%Backup%\Mouse.reg" /y
echo %TitleMessage% Сохранение произведено. |"%nColor%" %TextColor%
timeout /t 2 >nul
goto ApplyChanged