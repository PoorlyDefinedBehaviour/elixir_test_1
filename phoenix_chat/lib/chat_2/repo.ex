defmodule Chat2.Repo do
  use Ecto.Repo,
    otp_app: :chat_2,
    adapter: Ecto.Adapters.Postgres
end
