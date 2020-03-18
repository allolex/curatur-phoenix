# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

db_user = System.get_env("POSTGRES_USER") ||
    raise """
    environment variable POSTGRES_USER is missing.
    """

db_host = System.get_env("DATABASE_HOST") ||
    raise """
    environment variable DATABASE_HOST is missing.
    """

db_password = System.get_env("POSTGRES_PASSWORD") || 
    raise """
    environment variable POSTGRES_PASSWORD is missing.
    """

db_name = System.get_env("DATABASE_NAME") ||
    raise """
    environment variable DATABASE_NAME is missing.
    """

database_url = "ecto://#{db_user}:#{db_password}@#{db_host}/#{db_name}"

config :curatur,
  ecto_repos: [Curatur.Repo]

config :curatur, Curatur.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: database_url,
  pool_size: 15

port = String.to_integer(System.get_env("PORT") || "4000")

# Configures the endpoint
config :curatur, CuraturWeb.Endpoint,
  http: [port: port],
  live_view: [signing_salt: "sR3MBzxY"],
  pubsub: [name: Curatur.PubSub, adapter: Phoenix.PubSub.PG2],
  render_errors: [view: CuraturWeb.ErrorView, accepts: ~w(html json)],
  root: ".",
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  url: [host: "localhost", port: port ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :peerage, via: Peerage.Via.Dns,
  dns_name: "localhost",
  app_name: "curatur"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
