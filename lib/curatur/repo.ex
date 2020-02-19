defmodule Curatur.Repo do
  use Ecto.Repo,
    otp_app: :curatur,
    adapter: Ecto.Adapters.Postgres
end
