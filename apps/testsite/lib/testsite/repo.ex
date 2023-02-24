defmodule Testsite.Repo do
  use Ecto.Repo,
    otp_app: :testsite,
    adapter: Ecto.Adapters.Postgres
end
