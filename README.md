# Orbit: Student Finance and Club Budget Management

Orbit is an app for CS 3200 focused on student financial operations. The platform combines shared-expense tracking, club budget management, support workflows, and spending analytics in one role-based application.

[Watch our demo video](https://drive.google.com/file/d/1qzlFxD4avM3hgavZooxR_AS8f17HAcYc/view?usp=sharing)

## Team Members

- Oscar Peng
- Samuel Shrestha
- Sharon Wilfred
- Sally Esquith
- Addison Apisarnthanarax


## Project Overview

Orbit supports common student finance workflows:

- Shared living expenses (create, update, split, and track payment status)
- Club expenses and reimbursements
- Category and dashboard filter management
- Support issue tracking and status updates
- Analytics for spending trends and student-group behavior

## Repository Structure

- app: Streamlit application
- api: Flask REST API and DB connection logic
- database-files: SQL schema and mock data
- ml-src: ML experimentation/training workspace
- docs: Additional documentation

## Prerequisites

- Docker Desktop 
- Python 3.11 
- VS Code 

Dependencies:

```bash
cd api
pip install -r requirements.txt
cd ../app/src
pip install -r requirements.txt
```

## Environment Setup (.env)

1. Create api/.env from the template.

PowerShell:

```powershell
Copy-Item api/.env.template api/.env
```

macOS/Linux:

```bash
cp api/.env.template api/.env
```

2. Open api/.env and set values.

Format:

```env
SECRET_KEY=<change-this-to-a-random-secret>
DB_USER=root
DB_HOST=db
DB_PORT=3306
DB_NAME=Starline-DB
MYSQL_ROOT_PASSWORD=<change-this-to-a-strong-password>
```

Important notes:

- DB_NAME must match the SQL schema name used by database-files/01-Starline-DB.sql.


## Quick Start

From the repository root:

```bash
docker compose up -d
```

Open:

- App: http://localhost:8501
- API: http://localhost:4000
- MySQL: localhost:3200

Check status:

```bash
docker compose ps
```

Stop services:

```bash
docker compose down
```

## Database Initialization and SQL Execution

On first DB container creation, SQL files in database-files are executed automatically in alphabetical order:

1. database-files/01-Starline-DB.sql 
2. database-files/02-Mock_data.sql 

If you change SQL files later, you must recreate the DB container volume to rerun scripts:

```bash
docker compose down db -v
docker compose up db -d
```

The -v flag removes the MySQL volume so initialization scripts run again on next creation.

## Sandbox Environment

For personal testing:

```bash
docker compose -f sandbox.yaml up -d
docker compose -f sandbox.yaml down
```

Sandbox ports:

- App: 8502
- API: 4001
- DB: 3201

### Core Features

- Shared expense tracking for roommates and small groups
- Club expense management for budgeting and reimbursements
- Category management for organizing expenses
- Dashboard filters and analytics for viewing spending trends
- Support issue tracking for administrative workflows

## User Roles in the App

Orbit currently provides role-based navigation for these personas:

- Jude: shared expense logging, payment tracking, expense history
- Daniel: club expense logging, reimbursements, budget summary
- Sofia: category management, flagged transaction review, support issue workflow
- Rachel: category spending analysis, student-group analysis, dashboard filters

## Current blueprints

- /shared-expenses
- /club-expenses
- /categories
- /dashboard-filters
- /analytics
- /expense-splits
- /support-issues

## Development Notes

- Streamlit and Flask code changes are hot-reloaded inside containers.
- SQL initialization scripts only run automatically on first database creation.
- If database scripts are updated later, the database volume may need to be recreated.

## Troubleshooting

- Check all containers are running:
```bash
docker compose ps
```

- Check api logs:
```bash
docker compose logs api
```

- Check app logs:
```bash
docker compose logs app
```


