defmodule ApolochatCore.Repo do
  use Ecto.Repo,
    otp_app: :apolochat_core,
    adapter: Ecto.Adapters.Postgres
end
