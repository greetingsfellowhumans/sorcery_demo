defmodule Src.Queries.GetPlayer do

  use Sorcery.Query, %{
    find: %{
      "?player" => :*,
    },
    args: %{
      player_id: :integer
    },
    where: [
      [ "?player", :player, :id, :args_player_id],
    ]
  }

end
