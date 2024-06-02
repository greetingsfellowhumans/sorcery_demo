# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SorceryGame.Repo.insert!(%SorceryGame.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Src.Schemas.{Player, BattleArena, Team, SpellType, SpellInstance}
alias SorceryGame.Repo

arena_names = ["Ice Room", "Candy Land", "Fire Pit"]
spells = [
  %{name: "Heal", power: -10, cost: 25},
  %{name: "Fireball", power: 40, cost: 85},
  %{name: "Pew Pew", power: 15, cost: 10},
]
for spell <- spells do
  cs = SpellType.gen_cs(spell)
  dbg cs
  Repo.insert!(SpellType.gen_cs(spell))
end

for name <- arena_names do
  arena = Repo.insert!(BattleArena.gen_cs(%{name: name}))

  # 2 teams are in each arena
  for _n <- 1..2 do
    team = Repo.insert!(Team.gen_cs(%{location_id: arena.id}))

    # 2 players on each team
    for _n <- 1..2 do
      Repo.insert!(Player.gen_cs(%{team_id: team.id}))
    end
  end
end

all_spells = Repo.all(SpellType)
all_players = Repo.all(Player)
for spell <- all_spells, player <- all_players do
  Repo.insert!(SpellInstance.gen_cs(%{type_id: spell.id, player_id: player.id}))
end

