.PHONY: install
install:
	poetry install

.PHONY: migrate
migrate:
	poetry run python -m src.manage migrate

.PHONY: migrations
migrations:
	poetry run python -m src.manage makemigrations

.PHONY: superuser
superuser:
	poetry run python -m src.manage createsuperuser

.PHONY: runserver
runserver:
	poetry run python -m src.manage runserver

.PHONY: update
update: install migrate;
