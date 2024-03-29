#!/bin/sh
# Runs the db migrations
set +x

# Construct the connection string for postgres
FIL_PG_CONNECT=postgresql://$DATABASE_USER:$DATABASE_PASSWORD@$DATABASE_HOSTNAME:$DATABASE_PORT/$DATABASE_NAME?sslmode=disable

# Run the DB migrations
echo "Connecting with: $FIL_PG_CONNECT"
echo "Running database migrations"
./goose -dir migrations postgres "$FIL_PG_CONNECT" up

if [ "$RUN_HYPERTABLE_MIGRATIONS" == "true" ]; then
    echo "Running hypertable migrations"
    ./goose -dir migrations/hypertable postgres "$FIL_PG_CONNECT" up
fi

# If the db migrations ran without err
if [[ $? -eq 0 ]]; then
    echo "Migration process ran successfully"
    tail -f /dev/null
else
    echo "Could not run migrations. Are the database details correct?"
    exit 1
fi
