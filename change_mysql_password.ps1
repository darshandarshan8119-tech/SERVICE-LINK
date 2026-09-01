$newPassword = "darshan123"
$user = "root"

Write-Host "------------------------------------------------"
Write-Host "MySQL Password Reset Script"
Write-Host "Changing password for '$user' to '$newPassword'..."
Write-Host "------------------------------------------------"

# This will prompt you for your CURRENT password
# Using the absolute path to mysql.exe
& "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u $user -p --execute="ALTER USER '$user'@'localhost' IDENTIFIED BY '$newPassword'; FLUSH PRIVILEGES;"


if ($LASTEXITCODE -eq 0) {
    Write-Host "`nSUCCESS: Password changed successfully!" -ForegroundColor Green
} else {
    Write-Host "`nERROR: Failed to change password." -ForegroundColor Red
    Write-Host "1. Make sure MySQL is running."
    Write-Host "2. Ensure you entered the CURRENT password correctly."
    Write-Host "3. If 'mysql' is not recognized, you need to add MySQL to your System PATH."
}

Write-Host "`nPress any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
