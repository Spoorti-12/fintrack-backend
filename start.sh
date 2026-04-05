#!/bin/bash
set -e

CONTAINER="finance-mysql"
DB_NAME="finance_db"
DB_USER="finance"
DB_PASS="finance123"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mysql_exec()  { docker exec -e MYSQL_PWD="$DB_PASS" "$CONTAINER" mysql      -u"$DB_USER" "$@"; }
mysqld_exec() { docker exec -e MYSQL_PWD="$DB_PASS" "$CONTAINER" mysqladmin  -u"$DB_USER" "$@"; }
dump_exec()   { docker exec -e MYSQL_PWD="$DB_PASS" "$CONTAINER" mysqldump   --no-tablespaces -u"$DB_USER" "$@"; }

trap 'echo ""; echo "Interrupted. Stopping containers..."; docker compose -f "$ROOT_DIR/docker-compose.yml" down; exit 1' INT TERM

echo "==> Building and starting all services..."
docker compose -f "$ROOT_DIR/docker-compose.yml" up -d --build

echo "==> Waiting for MySQL to be healthy..."
until mysqld_exec ping --silent 2>/dev/null; do
  printf "."
  sleep 3
done
echo " ready."

echo "==> Waiting for app to be ready..."
until docker exec finance-app wget -qO- http://localhost:8080/actuator/health 2>/dev/null | grep -q '"status":"UP"'; do
  printf "."
  sleep 5
done
echo " ready."

echo "==> Loading mock data..."
mysql_exec "$DB_NAME" < "$ROOT_DIR/scripts/mock-data.sql"
echo "    Mock data loaded."

echo "==> Dumping database..."
DUMP_DIR="$ROOT_DIR/dumps"
mkdir -p "$DUMP_DIR"
OUTPUT_FILE="$DUMP_DIR/finance_dump_$(date +%Y%m%d_%H%M%S).sql"
dump_exec "$DB_NAME" > "$OUTPUT_FILE"
echo "    Dump saved: $OUTPUT_FILE"

echo ""
echo "==> Done. Open http://localhost"
