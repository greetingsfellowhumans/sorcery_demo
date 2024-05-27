defmodule Src.Schemas.BattleArena do
  use Sorcery.Schema, 
    meta: %{ optional?: false },
    fields: %{
      name: %{t: :string, min: 4, max: 45, default: "Nameless"},
    }
end

