@ECHO OFF
if "%username%"=="%computername%$" (echo.) else (taskkill /f /im "explorer.exe")
::Очистка буфера обмена
start "" "%WINDIR%\System32\cmd.exe" /c "echo off | clip"
::очистить кэш DNS
ipconfig /flushdns
::Очистка журналов
For /F "Tokens=1* Delims==" %%A In ('WMIC NTEVENTLOG GET LogFileName /Value^|FindStr .') Do (
	Call WMIC NTEVENTLOG Where ^(LogFileName^="%%B"^) Call ClearEventLog 1>nul
)
C:\Windows\System32\rundll32.exe InetCpl.cpl,ClearMyTracksByProcess 255
rd /s /q "%WINDIR%\Downloaded Program Files"
::Очистка временных файлов
rd /s /q "%SYSTEMDRIVE%\MSOCache"
rd /s /q "%SYSTEMDRIVE%\Temp"
rd /s /q "%USERPROFILE%\AppData\Local\Temp"
rd /s /q "%WINDIR%\msdownld.tmp"
rd /s /q "%WINDIR%\Prefetch"
rd /s /q "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Temp"
rd /s /q "%WINDIR%\ServiceProfiles\NetworkService\AppData\Local\Temp"
rd /s /q "%WINDIR%\System32\DriverStore\Temp"
rd /s /q "%WINDIR%\System32\Macromed\Temp"
rd /s /q "%WINDIR%\SysWOW64\DriverStore\Temp"
rd /s /q "%WINDIR%\SysWOW64\Macromed\Temp"
rd /s /q "%WINDIR%\Temp"
rd /s /q "%WINDIR%\winsxs\Temp"
::Очистка logs
del "%WINDIR%\debug\*.log" /s /q
del "%WINDIR%\inf\*.log" /q
del "%WINDIR%\Microsoft.NET\Framework\*.log" /s /q
del "%WINDIR%\Performance\WinSAT\*.log" /q
del "%WINDIR%\ServiceProfiles\*.log" /s /q
del "%WINDIR%\System32\LogFiles\*.EVM*" /s /q
del "%WINDIR%\System32\LogFiles\*etl*.*" /s /q
del "%WINDIR%\System32\LogFiles\WUDF\*.*" /s /q
del "%WINDIR%\System32\wbem\Logs\*.log" /q
rd /s /q "%WINDIR%\Logs"
rd /s /q "%WINDIR%\security\Logs"
rd /s /q "%WINDIR%\System32\wbem\Logs"
rd /s /q "%WINDIR%\System32\winevt\Logs"
rd /s /q "%WINDIR%\SysWOW64\wbem\Logs"
::Очистка кэша установщиков драйверов
rd /s /q "%SYSTEMDRIVE%\ATI"
rd /s /q "%SYSTEMDRIVE%\Intel"
rd /s /q "%SYSTEMDRIVE%\NVIDIA"
::Очистка файлов ожидающих записи на диск
rd /s /q "%USERPROFILE%\AppData\Local\Microsoft\Windows\Burn"
::Очистка результатов поиска
del "%USERPROFILE%\AppData\Local\Microsoft\Windows\History\*.*" /s /q
::Очистка кэша эскизов
del "%USERPROFILE%\.thumbnails\*.*" /q
del /F /S /Q /A "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
cls
::Очистка проводника
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\CIDSizeMRU" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\FirstFolder" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StreamMRU" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\TypedPaths" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\WordWheelQuery" /f
::Очистка Paint
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\Recent File List" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\View" /v "BMPHeight" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Paint\View" /v "BMPWidth" /f
::Очистка всех значков в области уведомлений
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\CurrentVersion\TrayNotify" /v "IconStreams" /f
C:\Windows\System32\reg.exe delete "HKCU\SOFTWARE\Classes\Local Settings\SOFTWARE\Microsoft\Windows\CurrentVersion\TrayNotify" /v "PastIconsStream" /f
C:\Windows\System32\SCHTASKS.exe /Change /TN "\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable
C:\Windows\System32\SCHTASKS.exe /Change /TN "\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable
C:\Windows\System32\SCHTASKS.exe /Change /TN "\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable