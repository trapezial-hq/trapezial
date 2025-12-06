defmodule Trapezial.Repo do
  use Ecto.Repo,
    otp_app: :trapezial,
    adapter: Ecto.Adapters.Postgres
end
