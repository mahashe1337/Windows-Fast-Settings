@echo off
:: Отключение ненужных задач
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /f  REM Отключает задачу SmartScreen для специфических приложений
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\AitAgent" /f  REM Отключает агент AIT, который собирает данные о совместимости приложений
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /f  REM Отключает оценщик совместимости Microsoft
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /f  REM Отключает задачу обновления данных программ
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /f  REM Отключает задачу, связанную с запуском приложений
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\ApplicationData\appuriverifierdaily" /f  REM Отключает ежедневную проверку приложений
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\ApplicationData\appuriverifierinstall" /f  REM Отключает задачу проверки установки приложений
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Autochk\Proxy" /f  REM Отключает прокси для автоматической проверки диска
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /f  REM Отключает задачу сбора данных о Bluetooth для программы улучшения пользовательского опыта
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f  REM Отключает задачу консолидации данных программы улучшения пользовательского опыта
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /f  REM Отключает задачу сбора данных о ядре для программы улучшения пользовательского опыта
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f  REM Отключает задачу сбора данных о USB для программы улучшения пользовательского опыта
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /f  REM Отключает запланированную дефрагментацию диска
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Device Information\Device" /f  REM Отключает задачу сбора информации о устройствах
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Diagnosis\Scheduled" /f  REM Отключает запланированную диагностику системы
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /f  REM Отключает сбор данных диагностики диска
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /f  REM Отключает задачу установки языковых компонентов
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /f  REM Отключает задачу удаления языковых компонентов
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Maintenance\WinSAT" /f  REM Отключает задачу оценки производительности Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Maps\MapsToastTask" /f  REM Отключает задачу уведомлений карт
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Maps\MapsUpdateTask" /f  REM Отключает задачу обновления карт
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /f  REM Отключает парсер метаданных для мобильных широкополосных аккаунтов
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\MobilePC\HotStart" /f  REM Отключает задачу быстрого запуска для мобильных ПК
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\MUI\LPRemove" /f  REM Отключает задачу удаления языковых пакетов
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /f  REM Отключает сбор информации о сети
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /f  REM Отключает анализ системы для диагностики эффективности энергопотребления
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\RAC\RacTask" /f  REM Отключает задачу RAC (Reliability Analysis Component)
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /f  REM Отключает задачу удаленной помощи
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\RetailDemo\CleanupOfflineContent" /f  REM Отключает очистку оффлайн-контента для демонстрационных версий
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SettingSync\BackgroundUploadTask" /f  REM Отключает задачу фоновой синхронизации настроек
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SettingSync\BackupTask" /f  REM Отключает задачу резервного копирования настроек
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SettingSync\NetworkStateChangeTask" /f  REM Отключает задачу изменения состояния сети для синхронизации настроек
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Setup\EOSNotify" /f  REM Отключает уведомления о завершении поддержки Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Setup\EOSNotify2" /f  REM Отключает вторичное уведомление о завершении поддержки Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Setup\SetupCleanupTask" /f  REM Отключает задачу очистки после установки Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /f  REM Отключает задачу загрузки моделей распознавания речи
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SystemRestore\SR" /f  REM Отключает задачу восстановления системы
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Time Synchronization\SynchronizeTime" /f  REM Отключает задачу синхронизации времени
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /f  REM Отключает задачу отчетности об ошибках Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\WindowsBackup\ConfigNotification" /f  REM Отключает уведомления о конфигурации резервного копирования Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\WS\License Validation" /f  REM Отключает задачу проверки лицензии Windows
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\WS\WSRefreshBannedAppsListTask" /f  REM Отключает задачу обновления списка запрещенных приложений
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\XblGameSave\XblGameSaveTask" /f  REM Отключает задачу сохранения игр Xbox Live
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon" /f  REM Отключает задачу сохранения игр Xbox Live при входе в систему
:: Отключение задач NVIDIA
C:\Windows\System32\schtasks.exe /Change /TN "\NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable
C:\Windows\System32\schtasks.exe /Change /TN "\NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable
C:\Windows\System32\schtasks.exe /Change /TN "\NvTmRepOnLogon_{B2FE1952-0186-46C3-BAEC-A80AA35AC5B8}" /Disable

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\AppID\SmartScreenSpecific" /f                                        &rem - 9 B  ; Отключает задачу, связанную с конкретными настройками SmartScreen для приложений.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\AitAgent" /f                                  &rem 7 9 -  ; Отключает агент, который собирает данные о совместимости приложений.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /f         &rem 7 9 B  ; Отключает задачу, оценивающую совместимость приложений с Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\ProgramDataUpdater" /f                        &rem 7 9 B  ; Отключает задачу, обновляющую данные о приложениях.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Application Experience\StartupAppTask" /f                            &rem - 9 B  ; Отключает задачу, связанную с запуском приложений при старте системы.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\ApplicationData\appuriverifierdaily" /f                              &rem - - B  ; Отключает ежедневную проверку приложений.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\ApplicationData\appuriverifierinstall" /f                            &rem - - B  ; Отключает проверку приложений при установке.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Autochk\Proxy" /f                                                    &rem 7 9 B  ; Отключает задачу, связанную с проверкой дисков (Autochk).

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\BthSQM" /f                   &rem - 9 -  ; Отключает задачу, связанную с программой улучшения пользовательского опыта для Bluetooth.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /f             &rem 7 9 B  ; Отключает задачу, собирающую данные для программы улучшения пользовательского опыта.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask" /f           &rem 7 9 B  ; Отключает задачу, собирающую данные о работе ядра для программы улучшения пользовательского опыта.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Customer Experience Improvement Program\UsbCeip" /f                  &rem 7 9 B  ; Отключает задачу, собирающую данные о USB-устройствах для программы улучшения пользовательского опыта.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Defrag\ScheduledDefrag" /f                                           &rem 7 9 B  ; Отключает запланированную дефрагментацию диска.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Device Information\Device" /f                                        &rem - - B  ; Отключает задачу, связанную с информацией об устройствах.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Diagnosis\Scheduled" /f                                              &rem 7 9 B  ; Отключает запланированную диагностику системы.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector" /f     &rem 7 9 B  ; Отключает сбор данных о состоянии диска.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\LanguageComponentsInstaller\Installation" /f                         &rem - - B  ; Отключает задачу установки языковых компонентов.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\LanguageComponentsInstaller\Uninstallation" /f                       &rem - - B  ; Отключает задачу удаления языковых компонентов.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Maintenance\WinSAT" /f                                               &rem 7 9 B  ; Отключает задачу, связанную с оценкой производительности системы (Windows System Assessment Tool).
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Maps\MapsToastTask" /f                                               &rem - - B  ; Отключает задачу, связанную с уведомлениями карт.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Maps\MapsUpdateTask" /f                                              &rem - - B  ; Отключает задачу обновления карт.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Mobile Broadband Accounts\MNO Metadata Parser" /f                    &rem - 9 B  ; Отключает задачу, связанную с парсингом метаданных для мобильных широкополосных соединений.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\MobilePC\HotStart" /f                                                &rem 7 - -  ; Отключает задачу быстрого запуска для мобильных ПК.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\MUI\LPRemove" /f                                                     &rem 7 9 B  ; Отключает задачу, связанную с удалением языковых пакетов.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\NetTrace\GatherNetworkInfo" /f                                       &rem 7 9 B  ; Отключает задачу сбора информации о сети.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem" /f                       &rem 7 9 B  ; Отключает задачу анализа системы для повышения энергоэффективности.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\RAC\RacTask" /f                                                      &rem 7 9 -  ; Отключает задачу, связанную с анализом и отчетами о производительности.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\RemoteAssistance\RemoteAssistanceTask" /f                            &rem 7 9 B  ; Отключает задачу удаленной помощи.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\RetailDemo\CleanupOfflineContent" /f                                 &rem - - B  ; Отключает задачу очистки оффлайн-контента для демонстрационных версий.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SettingSync\BackgroundUploadTask" /f                                 &rem - 9 B  ; Отключает задачу фоновой загрузки для синхронизации настроек.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SettingSync\BackupTask" /f                                           &rem - 9 B  ; Отключает задачу резервного копирования для синхронизации настроек.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SettingSync\NetworkStateChangeTask" /f                               &rem - 9 B  ; Отключает задачу, реагирующую на изменения состояния сети для синхронизации настроек.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Setup\EOSNotify" /f                                                  &rem 7 9 -  ; Отключает уведомления о завершении поддержки Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Setup\EOSNotify2" /f                                                 &rem 7 9 -  ; Отключает вторичное уведомление о завершении поддержки Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Setup\SetupCleanupTask" /f                                           &rem - 9 B  ; Отключает задачу очистки после установки Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Speech\SpeechModelDownloadTask" /f                                   &rem - - B  ; Отключает задачу загрузки моделей для распознавания речи.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\SystemRestore\SR" /f                                                 &rem 7 9 B  ; Отключает задачу восстановления системы.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting" /f                           &rem 7 9 B  ; Отключает задачу отчетности об ошибках Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\WindowsBackup\ConfigNotification" /f                                 &rem 7 - -  ; Отключает уведомления о конфигурации резервного копирования Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\WS\License Validation" /f                                            &rem - 9 -  ; Отключает задачу проверки лицензии Windows.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\Windows\WS\WSRefreshBannedAppsListTask" /f                                   &rem - 9 -  ; Отключает задачу обновления списка запрещенных приложений.

C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\XblGameSave\XblGameSaveTask" /f                                              &rem - - B  ; Отключает задачу сохранения игр в Xbox Live.
C:\Windows\System32\schtasks.exe /Delete /tn "\Microsoft\XblGameSave\XblGameSaveTaskLogon" /f                                         &rem - - B  ; Отключает задачу сохранения игр при входе в систему.

timeout 3 > nul
exit