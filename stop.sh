#!/bin/bash

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Stopping all services..."
docker compose -f "$ROOT_DIR/docker-compose.yml" down
echo "==> Done."
