defmodule Stocksliveview.Repo do
  use Ecto.Repo,
    otp_app: :stocksliveview,
    adapter: Ecto.Adapters.Postgres
end
