@echo off
setlocal

set CONTAINER=finance-mysql
set DB_NAME=finance_db
set DB_USER=finance
set DB_PASS=finance123
set ROOT_DIR=%~dp0

echo ==> Building and starting all services...
docker compose -f "%ROOT_DIR%docker-compose.yml" up -d --build
if %errorlevel% neq 0 exit /b %errorlevel%

echo ==> Waiting for MySQL to be healthy...
:wait_mysql
docker exec -e MYSQL_PWD=%DB_PASS% %CONTAINER% mysqladmin ping -u%DB_USER% --silent >nul 2>&1
if %errorlevel% neq 0 (
    timeout /t 3 /nobreak >nul
    goto wait_mysql
)
echo    ready.

echo ==> Waiting for app to be ready...
:wait_app
docker exec finance-app wget -qO- http://localhost:8080/actuator/health 2>nul | findstr /c:"\"status\":\"UP\"" >nul
if %errorlevel% neq 0 (
    timeout /t 5 /nobreak >nul
    goto wait_app
)
echo    ready.

echo ==> Loading mock data...
docker exec -i -e MYSQL_PWD=%DB_PASS% %CONTAINER% mysql -u%DB_USER% %DB_NAME% < "%ROOT_DIR%scripts\mock-data.sql"
if %errorlevel% neq 0 exit /b %errorlevel%
echo    Mock data loaded.

echo ==> Dumping database...
if not exist "%ROOT_DIR%dumps" mkdir "%ROOT_DIR%dumps"
for /f "tokens=1-6 delims=/: " %%a in ("%date% %time%") do set TIMESTAMP=%%c%%a%%b_%%d%%e%%f
set OUTPUT_FILE=%ROOT_DIR%dumps\finance_dump_%TIMESTAMP%.sql
docker exec -e MYSQL_PWD=%DB_PASS% %CONTAINER% mysqldump --no-tablespaces -u%DB_USER% %DB_NAME% > "%OUTPUT_FILE%"
echo    Dump saved: %OUTPUT_FILE%

echo.
echo ==> Done. Open http://localhost
endlocal
