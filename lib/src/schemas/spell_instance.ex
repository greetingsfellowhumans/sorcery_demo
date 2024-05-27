defmodule Src.Schemas.SpellInstance do
  use Sorcery.Schema, 
    meta: %{ optional?: false },
    fields: %{
      type_id: %{t: :fk, module: SorceryGame.Schemas.SpellType},
      player_id: %{t: :fk, module: SorceryGame.Schemas.Player},
    }
end

