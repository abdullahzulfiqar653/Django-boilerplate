Django Project Setup as boilerplate
=================================

instruction will go here:
mkdir -p local
cp src/core/settings/templetes/settings.dev.py ./local/settings.dev.py
export ENVIRONMENT=production
docker-compose -f docker-compose.yml up
