#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define a variable for the Django management command to avoid repetition and improve readability.
RUN_MANAGE_PY='poetry run python -m src.manage'
ENVIRONMENT=${ENVIRONMENT:-local}
echo "Environment: $ENVIRONMENT"

# Static files need to be collected for WhiteNoise to serve them in production. This is usually
# done once as part of deployment. TODO: Optimize to avoid repeating on every run.
# A named volume or a persistent storage mechanism could be used to achieve this.
echo 'Collecting static files...'
$RUN_MANAGE_PY collectstatic --no-input

# Apply database migrations. This is critical to ensure the database schema is up to date
# with the application's models.
echo 'Running migrations...'
$RUN_MANAGE_PY migrate --no-input



# Start the Project using Gunicorn in 2 Modes on server.
# Gunicorn is configured to listen on all network interfaces (0.0.0.0) and
# different ports according to the environment running on. Gunicorn uses
# the WSGI application from src.core.wsgi:application.
echo 'Starting the server...'

if [ "$ENVIRONMENT" = "dev" ]; then
    echo 'Starting with Gunicorn (Development Env)...'
    poetry run gunicorn -b 0.0.0.0:8000 src.core.wsgi:application

elif [ "$ENVIRONMENT" = "prod" ]; then
    echo 'Starting with Gunicorn (Production Env)...'
    poetry run gunicorn -b 0.0.0.0:8002 src.core.wsgi:application

elif [ "$ENVIRONMENT" = "local" ]; then
    echo 'Starting with Gunicorn (Local Mode)...'
    poetry run gunicorn --reload -b 0.0.0.0:8000 src.core.wsgi:application
fi
