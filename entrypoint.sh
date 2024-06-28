#!/bin/bash
set -e

# Wait for the MySQL service to be ready
until mysql -h "$MYSQL_HOST" -u root -p"$MYSQL_ROOT_PASSWORD" -e 'select 1'; do
  >&2 echo "MySQL is unavailable - sleeping"
  sleep 1
done

>&2 echo "MySQL is up - executing command"

# Check if the database exists
if ! mysql -h "$MYSQL_HOST" -u root -p"$MYSQL_ROOT_PASSWORD" -e "use $MYSQL_DATABASE"; then
  # If the database does not exist, create and migrate
  bundle exec rails db:create db:migrate

  # Create the test database
  bundle exec rails db:create db:migrate RAILS_ENV=test
else
  # If the database exists, just migrate
  bundle exec rails db:migrate
fi

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
