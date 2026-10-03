@echo off
TITLE Tradexpress Batch Installer
COLOR 0A

echo ===================================================
echo      TRADEXPRESS AUTOMATED BATCH INSTALLER
echo ===================================================

:: 1. Check and create target directories on Drive D
echo [1/4] Setting up directories on Drive D...
if not exist "D:\Projects\tradexpress" mkdir "D:\Projects\tradexpress"
if not exist "D:\Projects\tradexpress\backups" mkdir "D:\Projects\tradexpress\backups"

:: 2. Copy files from source to Drive D
echo [2/4] Copying necessary files...
xcopy /E /I /Y "%~dp0\*" "D:\Projects\tradexpress\"

:: 3. Create AppData symbolic link setup reference
echo [3/4] Configuring AppData and storage routing...
if not exist "D:\tradexpress\AppData" mkdir "D:\tradexpress\AppData"

:: 4. Create auto_zip.bat in the target folder for automation
echo [4/4] Setting up auto-zip backup script...
(
@echo off
cd /d D:\Projects\tradexpress
echo Starting auto-zip backup process...
powershell -Command "Compress-Archive -Path 'D:\Projects\tradexpress\*' -DestinationPath 'D:\Projects\tradexpress\backups\backup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.zip' -Force"
echo Backup completed successfully!
) > "D:\Projects\tradexpress\auto_zip.bat"

echo ===================================================
echo      INSTALLATION AND SETUP COMPLETED SUCCESSFULLY!
echo ===================================================
pause