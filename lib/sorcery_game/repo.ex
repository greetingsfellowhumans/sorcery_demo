defmodule SorceryGame.Repo do
  use Ecto.Repo,
    otp_app: :sorcery_game,
    adapter: Ecto.Adapters.Postgres
end
