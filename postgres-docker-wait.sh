#!/bin/bash

# this script runs from the web container
# it uses psql to log into the pg-db container over the local network @pg-db
# then it tries a simple select command to ensure the DB is ready to accept connections.

# if postgres is ready, we create the relations from the migration file and start the server

# this script is necessary because postgres spins up and down before it is finally
# ready to accept connections. This means that simply checking if @pg-dev:5432 is open
# is insufficient

MAX_RETRIES=5
WAIT_TIME=3

# use for psql command
export PGPASSWORD=dev_pwd

# retry loop for connecting to the database
counter=0
until psql -h pg-db -U dev_user -d dev_db -c 'SELECT 1'; do
  counter=$((counter + 1))
  if [ $counter -ge $MAX_RETRIES ]; then
    echo "Failed to connect to database after $counter attempts, exiting"
    exit 1
  fi
  echo "Cannot connect to database, retrying in $WAIT_TIME seconds..."
  sleep $WAIT_TIME
done
echo "Database is ready to accept connections."

echo "creating relations"
flask db upgrade

echo "executing command: $@"
exec "$@"
