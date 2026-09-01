# Run this script as Administrator to reset your MySQL root password to 'darshan123'

$newPassword = "darshan123"
$initFilePath = "C:\reset_pass_temp.txt"

Write-Host "--------------------------------------------------------" -ForegroundColor Cyan
Write-Host " Resetting MySQL Root Password to '$newPassword'" -ForegroundColor Cyan
Write-Host "--------------------------------------------------------" -ForegroundColor Cyan

# 1. Stop MySQL Services
Write-Host "`n[1/4] Stopping MySQL Service..." -ForegroundColor Yellow
Stop-Service -Name "newMySQL80" -ErrorAction SilentlyContinue
Stop-Service -Name "MySQL80" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# 2. Create init file
Write-Host "[2/4] Creating temporary password reset file..." -ForegroundColor Yellow
"ALTER USER 'root'@'localhost' IDENTIFIED BY '$newPassword';" | Out-File -FilePath $initFilePath -Encoding ascii

# 3. Find mysqld.exe and my.ini
$mysqldPath = "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqld.exe"
$myIniPath = "C:\ProgramData\MySQL\MySQL Server 8.0\my.ini"

if (-not (Test-Path $mysqldPath)) {
    Write-Host "ERROR: mysqld.exe not found at $mysqldPath" -ForegroundColor Red
    exit 1
}

Write-Host "[3/4] Applying new password..." -ForegroundColor Yellow
$process = Start-Process -FilePath $mysqldPath -ArgumentList "--defaults-file=`"$myIniPath`"", "--init-file=`"$initFilePath`"" -PassThru -NoNewWindow
Start-Sleep -Seconds 5
if (-not $process.HasExited) {
    Stop-Process -Id $process.Id -Force -ErrorAction SilentlyContinue
}

# Remove temporary file
Remove-Item -Path $initFilePath -ErrorAction SilentlyContinue

# 4. Restart MySQL Service
Write-Host "[4/4] Restarting MySQL Service..." -ForegroundColor Yellow
Start-Service -Name "newMySQL80" -ErrorAction SilentlyContinue
Start-Service -Name "MySQL80" -ErrorAction SilentlyContinue

Write-Host "`n--------------------------------------------------------" -ForegroundColor Green
Write-Host " SUCCESS: Password reset complete! Try 'darshan123' now." -ForegroundColor Green
Write-Host "--------------------------------------------------------" -ForegroundColor Green
