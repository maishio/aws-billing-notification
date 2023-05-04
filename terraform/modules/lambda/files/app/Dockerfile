FROM python:3.9.13-slim-bullseye as python-base

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

ENV PIP_NO_CACHE_DIR=off
ENV PIP_DISABLE_PIP_VERSION_CHECK=on
ENV PIP_DEFAULT_TIMEOUT=100

ENV POETRY_VERSION=1.4.0
ENV POETRY_HOME="/opt/poetry"
ENV POETRY_VIRTUALENVS_CREATE=false

ENV PYSETUP_PATH="/opt/pysetup"
ENV PATH="$POETRY_HOME/bin:$PATH"

# For initialize
FROM python-base as initial
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    build-essential

RUN curl -sSL https://install.python-poetry.org | python3 -

WORKDIR $PYSETUP_PATH

# For build
FROM initial as build-base
ENV POETRY_NO_INTERACTION=1
COPY poetry.lock pyproject.toml ./

# For development
FROM build-base as development
RUN poetry install
WORKDIR /app

# For production build
FROM build-base as production-build
RUN poetry install --only main

# For production
FROM python-base as production
COPY --from=production-build /usr/local/lib/python3.9/site-packages /usr/local/lib/python3.9/site-packages
COPY ./notify_aws_billing /app/notify_aws_billing
WORKDIR /app
CMD ["python", "-m", "notify_aws_billing.main"]
