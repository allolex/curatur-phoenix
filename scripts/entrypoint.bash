#!/usr/bin/env bash
while ! pg_isready -q --host=$DATABASE_HOST --port 5432 --username=$POSTGRES_USER
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

mix ecto.migrate  # migrate your database if Ecto is used

# mix escript.build # create application executable binary

mix phx.digest
mix phx.server
