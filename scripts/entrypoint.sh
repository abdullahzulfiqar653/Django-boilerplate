#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Define a variable for the Django management command to avoid repetition and improve readability.
RUN_MANAGE_PY='poetry run python -m src.manage'
ENVIRONMENT=${ENVIRONMENT:-production}
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

# Start the Core API using Daphne ASGI server. Daphne is configured to listen on all network
# interfaces (0.0.0.0) at port 8000. These settings can be customized as needed.
echo 'Starting the Core API...'

if [ "$ENVIRONMENT" = "dev" ]; then
    echo 'Starting with Gunicorn (Development Mode)...'
    poetry run gunicorn --reload -b 0.0.0.0:8000 src.core.wsgi:application
else
    echo 'Starting with Gunicorn (Production Mode)...'
    poetry run gunicorn -b 0.0.0.0:8000 src.core.wsgi:application
fi
