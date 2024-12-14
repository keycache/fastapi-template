#!/bin/bash

DB_SERVICE=$1
CMD="$2 $3 $4"

until pg_isready -h $DB_SERVICE -q; do
  echo "Waiting for $DB_SERVICE to be ready..."
  sleep 1
done

echo "Running migrations..."
exec $CMD
echo "Migrations completed."
