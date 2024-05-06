defmodule MetasFin.Repo do
  use Ecto.Repo,
    otp_app: :metas_fin,
    adapter: Ecto.Adapters.Postgres
end
