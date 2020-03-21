# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

app_host = System.fetch_env!("APP_HOST")
service_name = System.fetch_env!("SERVICE_NAME")

secret_key_base = System.get_env("SECRET_KEY_BASE") ||
  raise "Environment variable SECRET_KEY_BASE is missing. You can generate one by calling: mix phx.gen.secret"

db_host = System.fetch_env!("DATABASE_HOST")
db_name = System.fetch_env!("DATABASE_NAME")
db_password = System.fetch_env!("POSTGRES_PASSWORD")
db_user = System.fetch_env!("POSTGRES_USER")

database_url = "ecto://#{db_user}:#{db_password}@#{db_host}/#{db_name}"

port = String.to_integer(System.get_env("PORT") || "4000")

config :curatur, Curatur.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

config :curatur, CuraturWeb.Endpoint,
  http: [
    port: port,
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base,
  url: [
    host: app_host,
    port: port
  ]

config :peerage, via: Peerage.Via.Dns,
  dns_name: service_name,
  app_name: "curatur"

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :curatur, CuraturWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
