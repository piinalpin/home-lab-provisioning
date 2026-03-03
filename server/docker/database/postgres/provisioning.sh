#!/bin/bash
set -e

while [[ $# -gt 0 ]]; do
  case $1 in
    --user=*)
      APP_USER="${1#*=}"
      shift
      ;;
    --password=*)
      APP_PASSWORD="${1#*=}"
      shift
      ;;
    --database=*)
      APP_DB="${1#*=}"
      shift
      ;;
    *)
      shift
      ;;
  esac
done

if [ -z "$APP_USER" ] || [ -z "$APP_PASSWORD" ] || [ -z "$APP_DB" ]; then
  echo "Usage: provision --user= --password= --database="
  exit 1
fi

psql -U postgres <<SQL

DO \$\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = '$APP_USER') THEN
      CREATE ROLE $APP_USER LOGIN PASSWORD '$APP_PASSWORD';
   END IF;
END
\$\$;

DO \$\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_database WHERE datname = '$APP_DB') THEN
      CREATE DATABASE $APP_DB OWNER $APP_USER;
   END IF;
END
\$\$;

GRANT ALL PRIVILEGES ON DATABASE $APP_DB TO $APP_USER;

SQL