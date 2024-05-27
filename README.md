# SorceryGame

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now open TWO browser tabs/windows
In the first one, visit [`localhost:4000`](http://localhost:4000)
In the second one, visit [`localhost:4000/player/3`](http://localhost:4000/player/3)
(Or whatever id, I don't care)

## The page looks broken.
Yes, it is. I put 0 effort into the styling. Half the names are randomly generated and don't display correctly either.

Ignore that. Focus on the buttons. Heal, and Harm.

Notice that when you heal or harm player 3 on one tab, it instantly updates on the other tab.

## Not much of a game, is it?
Ya ya, fine. Maybe some day I will actually flesh this out more. 

Until then, take a look at the schemas and queries. Look at how mutations work and how you spawn portals.

The player_live and sandbox_live files are also really interesting!

This should give you all you need to get started building anything.

Good luck. Use this power for good. Don't burn down the tavern.
