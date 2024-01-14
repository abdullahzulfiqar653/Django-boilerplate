FROM python:3.11.2

WORKDIR /opt/project

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# setting BOILERPLATE_IN_DOCKER to True so settings can get that project running in docker
ENV BOILERPLATE_IN_DOCKER=true

# TODO(dmu) LOW: Reduce image size by removing obsolete files post-installation.
# Included build-essential to pre-empt issues with future packages requiring it.
# Plan to eliminate this inclusion once dependency list is stable, optimizing image size.
RUN set -xe \
    && apt-get update \
    && apt-get install -y build-essential libpq-dev \
    && pip install pip==23.0 virtualenvwrapper

# Install poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Add Poetry's bin directory to PATH
ENV PATH="/root/.local/bin:${PATH}"

# To optimize image build time, dependencies are installed here.
# This ensures that changes in the source code do not necessitate reinstallation of dependencies.
COPY ["pyproject.toml", "poetry.lock", "./"]
RUN poetry config virtualenvs.create false && poetry install --no-interaction --no-ansi

COPY . .
# this installs just the source code itself, since dependencies are installed before
RUN poetry install

EXPOSE 8000

COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
