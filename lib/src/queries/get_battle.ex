defmodule Src.Queries.GetBattle do

  use Sorcery.Query, %{
    find: %{
      "?arena" => :*,
      "?all_teams" => [:name, :location_id],
      "?all_players" => :*,
      "?spells" => :*,
      "?spell_types" => :*,
    },
    args: %{
      player_id: :integer
    },
    where: [
      [ "?player", :player, :id, :args_player_id],
      [ "?team", :team, :id, "?player.team_id"],
      [ "?arena", :battle_arena, :id, "?team.location_id"],
      [ "?all_teams", :team, :location_id, "?arena.id"],

      [ "?all_players", :player, [
        {:team_id, "?all_teams.id"},
        {:health, {:>, 0}},
      ]],          

      [ "?spells", :spell_instance, :player_id, "?all_players.id"],
      [ "?spell_types", :spell_type, :id, "?spells.type_id"],
    ]
  }

end

