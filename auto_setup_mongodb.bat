@echo off
echo ===================================================
echo MongoDB Automatic Setup Script
echo ===================================================

echo.
echo [1/5] Creating MongoDB data directory at C:\data\db...
if not exist "C:\data\db" mkdir "C:\data\db"

echo.
echo [2/5] Updating User PATH for future use...
set "MONGO_SERVER=C:\Program Files\MongoDB\Server\8.3\bin"
powershell -Command "$p = [Environment]::GetEnvironmentVariable('Path', 'User'); if ($p -notmatch 'MongoDB\\Server') { [Environment]::SetEnvironmentVariable('Path', $p + ';' + '%MONGO_SERVER%', 'User') }"

:: Also update current session PATH so commands work immediately in this script
set "PATH=%PATH%;%MONGO_SERVER%"

echo.
echo [3/5] Installing MongoDB Shell and Database Tools...
echo Please wait, downloading and installing... (You may get a User Account Control prompt, click Yes)
winget install MongoDB.Shell --accept-source-agreements --accept-package-agreements
winget install MongoDB.DatabaseTools --accept-source-agreements --accept-package-agreements

:: Append typical install locations to current session PATH just in case winget's PATH update isn't captured immediately
set "PATH=%PATH%;C:\Program Files\MongoDB\Tools\100\bin;C:\Users\%USERNAME%\AppData\Local\Programs\mongosh\;C:\Program Files\mongosh\"

echo.
echo [4/5] Starting MongoDB Server...
start "MongoDB Server" mongod

echo.
echo Waiting 5 seconds for server to start...
timeout /t 5 /nobreak >nul

echo.
echo [5/5] Importing data.json into 'usermanaged_19'...
if exist data.json (
    mongoimport --db usermanaged_19 --collection transactions_19 --file data.json
) else (
    echo Error: data.json not found in this folder!
)

echo.
echo Opening Mongo Shell for you...
start "MongoDB Shell" cmd /k "mongosh"

echo.
echo ===================================================
echo Setup Complete! 
echo A new "MongoDB Shell" window just opened.
echo You can use it to run:
echo    use usermanaged_19
echo    db.transactions_19.find()
echo ===================================================
pause
