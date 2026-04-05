@echo off
setlocal

set ROOT_DIR=%~dp0

echo ==> Stopping all services...
docker compose -f "%ROOT_DIR%docker-compose.yml" down
echo ==> Done.

endlocal
