# Ensure Database Exists
Write-Host "Checking/Creating MySQL Database..." -ForegroundColor Yellow
& "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe" -u root -p"darshan123" -e "CREATE DATABASE IF NOT EXISTS servicelink;"

# Start the Backend Server
Write-Host "Starting Django Backend Server..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd servicelink_backend; .\.venv\Scripts\activate; python manage.py migrate; python seed_data.py; python manage.py runserver"

# Start the Frontend Server
Write-Host "Starting React Frontend Server..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd servicelink_frontend; npm run dev"

Write-Host "Both servers have been launched in separate windows!" -ForegroundColor Cyan
