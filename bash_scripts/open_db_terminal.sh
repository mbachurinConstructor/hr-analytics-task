#!/bin/bash
PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$PROJECT_DIR"

docker exec -it hr-analytics-task-postgres-1 psql -U admin -d hr_analytics