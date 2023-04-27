#!/bin/bash

docker rm -f $(docker ps -a -q)

docker volume rm $(docker volume ls -q)

docker-compose -f docker-compose.test.yml up -d test-db
sleep 5s

export HOST_NAME=localhost
export PORT=8088
export USER=fil
export TEST_DB=filecoin_testing
export TEST_CONNECT_STRING=postgresql://$USER@$HOST_NAME:$PORT/$TEST_DB?sslmode=disable
export PGPASSWORD=password

goose -dir ./db/migrations postgres "$TEST_CONNECT_STRING" status

curl -LJO https://jdbc.postgresql.org/download/postgresql-42.3.1.jar
curl -LJO https://github.com/schemaspy/schemaspy/releases/download/v6.1.0/schemaspy-6.1.0.jar
sudo apt-get update
sudo apt-get install -y graphviz

java -jar schemaspy-6.1.0.jar -t pgsql -dp postgresql-42.3.1.jar -host localhost -db database -u username -p password -o output
