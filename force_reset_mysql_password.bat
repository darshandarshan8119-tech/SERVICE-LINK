@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo ========================================================
    echo ERROR: MUST RUN AS ADMINISTRATOR!
    echo Right-click this file and select 'Run as administrator'
    echo ========================================================
    echo.
    pause
    exit /b
)

echo ========================================================
echo Force Resetting MySQL Root Password to 'darshan123'
echo ========================================================

echo [1/5] Stopping MySQL Services & Processes...
net stop newMySQL80 /y >nul 2>&1
net stop MySQL80 /y >nul 2>&1
taskkill /F /IM mysqld.exe >nul 2>&1
timeout /t 2 /nobreak >nul

echo [2/5] Creating reset script...
echo ALTER USER 'root'@'localhost' IDENTIFIED BY 'darshan123'; > C:\reset_pass_temp.txt
echo FLUSH PRIVILEGES; >> C:\reset_pass_temp.txt

echo [3/5] Updating Password in MySQL...
start "" /b "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe" --defaults-file="C:\ProgramData\MySQL\MySQL Server 8.0\my.ini" --init-file="C:\reset_pass_temp.txt" --console
timeout /t 6 /nobreak >nul

echo [4/5] Cleaning up background mysqld process...
taskkill /F /IM mysqld.exe >nul 2>&1
del C:\reset_pass_temp.txt >nul 2>&1
timeout /t 2 /nobreak >nul

echo [5/5] Restarting MySQL Service...
net start newMySQL80 >nul 2>&1

echo.
echo ========================================================
echo SUCCESS: MySQL Root Password is now set to: darshan123
echo ========================================================
echo.
pause
