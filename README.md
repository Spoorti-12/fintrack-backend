# Finance Data Processing & Access Control — Full Stack

A production-style finance dashboard with role-based access control, transaction management, analytics, request tracking, structured logging, and full observability. Built as a full-stack application with a React frontend and Spring Boot backend.

---

## Quick Start

> **Requires:** [Docker Desktop](https://www.docker.com/products/docker-desktop) installed and running. No Java or Node.js needed.

**Mac / Linux:**
```bash
chmod +x start.sh stop.sh
./start.sh
```

**Windows:**
```bat
start.bat
```

One command builds all services, waits for them to be healthy, loads 76 mock transactions, and dumps the database.

**Open the app:** http://localhost

| Service | URL | Credentials |
|---|---|---|
| Web UI | http://localhost | See seeded users below |
| Prometheus | http://localhost:9090 | — |
| Grafana | http://localhost:3000 | admin / admin |
| Health | http://localhost/actuator/health | — |

**To stop — Mac / Linux:**
```bash
./stop.sh
```

**To stop — Windows:**
```bat
stop.bat
```

---

## Seeded Users

Auto-created on first startup. Use the top-right **account switcher** in the UI to switch roles without logging out.

| Email | Password | Role |
|---|---|---|
| admin@finance.com | password123 | ADMIN |
| analyst@finance.com | password123 | ANALYST |
| viewer@finance.com | password123 | VIEWER |

---

## Role Permission Matrix

| Feature | VIEWER | ANALYST | ADMIN |
|---|---|---|---|
| Login / Register | ✅ | ✅ | ✅ |
| View transactions (filters + sorting) | ✅ | ✅ | ✅ |
| Dashboard (summary, charts, trends) | ✅ | ✅ | ✅ |
| Create / Update transactions | ❌ | ✅ | ✅ |
| Delete transactions (soft delete) | ❌ | ❌ | ✅ |
| User management | ❌ | ❌ | ✅ |

---

## Project Structure

```
├── backend/          Spring Boot 3 API (Java 21)
├── frontend/         React 18 + Vite + Tailwind CSS
├── infra/
│   ├── prometheus/   Prometheus config + Dockerfile
│   └── grafana/      Grafana provisioning + Dockerfile
├── scripts/          load-mock-data.sh, dump-data.sh, mock-data.sql
├── dumps/            DB dump output directory
├── docker-compose.yml
└── README.md
```

---

## Stack

| Layer | Technology |
|---|---|
| Frontend | React 18 + Vite + Tailwind CSS |
| Backend | Java 21 + Spring Boot 3.2 |
| Database | MySQL 8 |
| Auth | JWT (stateless) |
| Build | Maven + npm |
| Monitoring | Micrometer + Prometheus + Grafana |
| Testing | JUnit 5 + Mockito + MockMvc |
| Infra | Docker Compose + Nginx |

---

## Manual Setup (Without Docker)

**Prerequisites:** Java 21, Maven 3.9+, MySQL 8, Node.js 18+

```bash
# 1. Create database
mysql -u root -p -e "CREATE DATABASE finance_db; CREATE USER 'finance'@'localhost' IDENTIFIED BY 'finance123'; GRANT ALL ON finance_db.* TO 'finance'@'localhost';"

# 2. Start backend
cd backend
mvn spring-boot:run

# 3. Start frontend (new terminal)
cd frontend
npm install
npm run dev
# Frontend: http://localhost:5173

# 4. Load mock data
mysql -u finance -pfinance123 finance_db < scripts/mock-data.sql
```

---

## Frontend Features

- **Dashboard** — income/expense summary cards, monthly bar chart, category donut chart, recent transactions
- **Transactions** — paginated list with filters (type, category, date range) and sortable columns (date, category, type, amount)
- **Transaction Form** — create and edit with type toggle (Income / Expense)
- **Analytics** — charts for trends and category breakdowns
- **Users** — admin-only user management
- **Role Switcher** — one-click account switching in the top-right dropdown
- **403 Page** — full centered access-denied screen for unauthorized routes

---

## API Reference

### Authentication

```bash
# Register
curl -X POST http://localhost/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{"name":"Alice","email":"alice@example.com","password":"password123","role":"ANALYST"}'

# Login — copy token from response
curl -X POST http://localhost/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"admin@finance.com","password":"password123"}'

export TOKEN="<paste token here>"
```

### Transactions

```bash
# Create (ADMIN or ANALYST)
curl -X POST http://localhost/api/transactions \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"amount":5000,"type":"INCOME","category":"Salary","date":"2026-04-04","description":"Monthly salary"}'

# List with filters and sorting (all roles)
curl "http://localhost/api/transactions?type=INCOME&category=Salary&from=2026-01-01&to=2026-04-30&page=0&size=10&sort=date,desc" \
  -H "Authorization: Bearer $TOKEN"

# Get by ID
curl http://localhost/api/transactions/1 \
  -H "Authorization: Bearer $TOKEN"

# Update (ADMIN or ANALYST)
curl -X PUT http://localhost/api/transactions/1 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"amount":6000,"type":"INCOME","category":"Salary","date":"2026-04-04"}'

# Soft delete (ADMIN only)
curl -X DELETE http://localhost/api/transactions/1 \
  -H "Authorization: Bearer $TOKEN"
```

Sort options: `sort=date,desc` · `sort=amount,asc` · `sort=category,asc` · `sort=type,desc`

### Dashboard (all roles)

```bash
curl http://localhost/api/dashboard/summary      -H "Authorization: Bearer $TOKEN"
curl http://localhost/api/dashboard/by-category  -H "Authorization: Bearer $TOKEN"
curl http://localhost/api/dashboard/trends        -H "Authorization: Bearer $TOKEN"
curl http://localhost/api/dashboard/recent        -H "Authorization: Bearer $TOKEN"
```

### User Management (ADMIN only)

```bash
curl http://localhost/api/users -H "Authorization: Bearer $TOKEN"

curl -X PUT http://localhost/api/users/2 \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"role":"VIEWER"}'

curl -X DELETE http://localhost/api/users/2 -H "Authorization: Bearer $TOKEN"
```

---

## Error Response Format

```json
{
  "timestamp": "2026-04-04T10:00:00",
  "status": 403,
  "error": "Forbidden",
  "message": "You do not have permission to perform this action",
  "correlationId": "550e8400-e29b-41d4-a716-446655440000",
  "path": "/api/transactions"
}
```

Every response includes an `X-Correlation-Id` header for end-to-end request tracing.

---

## Monitoring

| Service | URL | Credentials |
|---|---|---|
| Prometheus | http://localhost:9090 | — |
| Grafana | http://localhost:3000 | admin / admin |
| Health | http://localhost/actuator/health | — |
| Metrics (raw) | http://localhost/actuator/prometheus | — |

Custom metrics: `finance.auth.login.success`, `finance.auth.login.failure`, `finance.transactions.created{type}`, `finance.dashboard.requests`

---

## Data Scripts

```bash
# Load 76 mock transactions (Oct 2025 – Apr 2026, multiple categories)
./scripts/load-mock-data.sh

# Dump current DB to a timestamped file in dumps/
./scripts/dump-data.sh
```

---

## Run Tests

```bash
cd backend
mvn test
```

Uses H2 in-memory DB — no MySQL required.

---

## Design Decisions

- **Soft delete** — `deleted_at` timestamp; rows never physically removed
- **Stateless JWT** — role embedded in token; no server-side session; horizontally scalable
- **Correlation ID** — every request gets a UUID in MDC, returned as `X-Correlation-Id` header
- **DB indexes** on `type`, `category`, `date`, `amount`, `deleted_at`, `email`
- **Pagination everywhere** — no unbounded queries; default page=0, size=20
- **SOLID** — each service has an interface; controllers depend on abstractions only
