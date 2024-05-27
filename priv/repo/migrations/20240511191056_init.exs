defmodule SorceryGame.Repo.Migrations.Init do
  use Ecto.Migration

  def change do

      create table("battle_arena") do
        add :name,   :string
      end

      create table("team") do
        add :name,   :string
        add :location_id, references("battle_arena")
      end

      create table("player") do
        add :name,      :string
        add :team_id,   references("team")
        add :health,    :integer
        add :mana,      :integer
        add :age,       :integer
        add :money,     :integer
      end

      create table("spell_type") do
        add :name,      :string
        add :cost,      :integer
        add :power,     :integer
      end

      create table("spell_instance") do
        add :player_id, references("player")
        add :type_id, references("spell_type")
      end

  end

end

