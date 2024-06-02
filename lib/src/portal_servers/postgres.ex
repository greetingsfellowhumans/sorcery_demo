defmodule Src.PortalServers.Postgres do
  use GenServer
  use Sorcery.GenServerHelpers


  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end


  @impl true
  def init(_) do
    state = %{} # You can still add whatever you want here
    state = initialize_sorcery(state, %{
      config_module: Src,
      store_adapter: Sorcery.StoreAdapter.Ecto,
      args: %{
        repo_module: SorceryGame.Repo
      }
    })

    {:ok, state}
  end


  @impl true
  def handle_info({:sorcery, msg}, state) do
    src = Sorcery.PortalServer.handle_info(msg, state.sorcery)
    {:noreply, Map.put(state, :sorcery, src)}
  end


end
