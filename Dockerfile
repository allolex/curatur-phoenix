FROM elixir:1.10.0-slim as build

WORKDIR /opt/curatur

ENV MIX_ENV prod

RUN apt-get update && apt-get install -y --no-install-recommends \
  git \
  locales \
  postgresql-client

ENV LANG en_US.UTF-8

# Turn on variables for build that are defined in the docker-compose config
ENV DATABASE_HOST=$DATABASE_HOST \
    DATABASE_NAME=$DATABASE_NAME \
    POSTGRES_USER=$POSTGRES_USER \
    POSTGRES_PASSWORD=$POSTGRES_PASSWORD

RUN echo $LANG UTF-8 > /etc/locale.gen \
    && locale-gen \
    && update-locale LANG=$LANG

# Install hex (Elixir package manager)
RUN mix local.hex --force

# Install rebar (Erlang build tool)
RUN mix local.rebar --force

# Copy all dependencies files
COPY mix.* ./

# Install all production dependencies
RUN mix deps.get --only prod

# Compile all dependencies
RUN mix deps.compile

# Copy all application files
COPY . .

# Compile the entire project
RUN mix compile

EXPOSE 4000

# Run the application itself
CMD ["./scripts/entrypoint.bash"]
