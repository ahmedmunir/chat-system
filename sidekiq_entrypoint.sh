#!/bin/bash
set -e

# Wait for the Redis service to be ready
until redis-cli -h redis ping | grep -q "PONG"; do
  >&2 echo "Redis is unavailable - sleeping"
  sleep 1
done

>&2 echo "Redis is up - executing command"

# Wait for the Rails migrations to be done
until bundle exec rails db:migrate:status; do
  >&2 echo "Waiting for database migrations to complete"
  sleep 1
done

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
