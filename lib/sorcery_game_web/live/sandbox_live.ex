defmodule SorceryGameWeb.SandboxLive do
  use Phoenix.LiveView
  use Sorcery.LiveHelpers

  #alias Sorcery.Mutation, as: M

  @impl true
  def mount(_param, _sess, socket) do
    socket = 
      socket
      |> initialize_sorcery(%{sorcery_module: Src})
      |> spawn_portal(%{
        portal_server: Postgres,
        portal_name: :battle_portal,
        query_module: GetBattle,
        query_args: %{player_id: 2}
      })


    {:ok, socket}
  end

  @impl true
  def handle_info({:sorcery, _} = msg, socket), do: handle_sorcery(msg, socket)

  @impl true
  def handle_event("change_hp", %{"id" => idstr, "amount" => amountstr}, socket) do
    id = String.to_integer(idstr)
    amount = String.to_integer(amountstr)

    Sorcery.Mutation.init(socket.assigns.sorcery, :battle_portal)
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
  <div>Rendering sandbox</div>
  <%= for player <- portal_view(@sorcery, :battle_portal, "?all_players") do %>
    <div style="margin: 1rem">
    <p><%= player.id %> | <%= player.name %>'s health: <%= player.health %></p>
    <button style="background: #595" phx-click="change_hp" phx-value-amount={1} phx-value-id={player.id}>Heal</button><br/>
    <button style="background: #955" phx-click="change_hp" phx-value-amount={-1} phx-value-id={player.id}>Harm</button><br/>
    </div>
  <% end %>
  """
  end



end
