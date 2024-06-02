defmodule SorceryGameWeb.PlayerLive do
  use Phoenix.LiveView
  use Sorcery.LiveHelpers


  @impl true
  def mount(%{"player_id" => idstr}, _sess, socket) do
    id = String.to_integer(idstr)
    socket = 
      socket
      |> initialize_sorcery(%{sorcery_module: Src})
      |> spawn_portal(%{
        portal_server: Postgres,
        portal_name: :player_portal,
        query_module: GetPlayer,
        query_args: %{player_id: id}
      })


    {:ok, socket}
  end

  @impl true
  def handle_info({:sorcery, _} = msg, socket), do: handle_sorcery(msg, socket)


  @impl true
  def handle_event("suffer", %{"id" => idstr, "amount" => amountstr}, socket) do
    id = String.to_integer(idstr)
    amount = String.to_integer(amountstr)

    Sorcery.Mutation.init(socket.assigns.sorcery, :player_portal)
    |> Sorcery.Mutation.update([:player, id, :health], fn _old_health, health -> health + amount end)
    |> Sorcery.Mutation.send_mutation(socket.assigns.sorcery)
    |> case do
      {:ok, new_sorcery} ->
        socket = assign(socket, :sorcery, new_sorcery)
        {:noreply, socket}

      {:error, _} ->
        {:noreply, socket}
    end
  end


  @impl true
  def render(assigns) do
  ~H"""
  <div>Rendering Profile</div>
  <% player = portal_view(@sorcery, :player_portal, "?player") |> List.first() %>
  <%= if is_map(player) do %>
    <% display_list = [name: "Name", health: "HP", age: "Age", team_id: "Team", mana: "Mana"] %>
    <%= for {k, str} <- display_list do %>
      <p><%= str%>: <%= player[k] %></p>
    <% end %>

    <br />
    <br />
    <button phx-click="suffer" phx-value-id={player.id} phx-value-amount={1}>Heal</button>

    <br />
    <br />
    <button phx-click="suffer" phx-value-id={player.id} phx-value-amount={-1}>Harm</button>
  <% end %>
  """
  end




end
