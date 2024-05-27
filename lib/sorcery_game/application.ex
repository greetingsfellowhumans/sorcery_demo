defmodule SorceryGame.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SorceryGameWeb.Telemetry,
      SorceryGame.Repo,
      {DNSCluster, query: Application.get_env(:sorcery_game, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SorceryGame.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SorceryGame.Finch},
      # Start a worker by calling: SorceryGame.Worker.start_link(arg)
      # {SorceryGame.Worker, arg},
      # Start to serve requests, typically the last entry
      SorceryGameWeb.Endpoint,
      {Src.PortalServers.Postgres, name: Src.PortalServers.Postgres},
      {Src, []},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SorceryGame.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SorceryGameWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
