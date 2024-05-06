defmodule MetasFin.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MetasFinWeb.Telemetry,
      MetasFin.Repo,
      {DNSCluster, query: Application.get_env(:metas_fin, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MetasFin.PubSub},
      # Start a worker by calling: MetasFin.Worker.start_link(arg)
      # {MetasFin.Worker, arg},
      # Start to serve requests, typically the last entry
      MetasFinWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MetasFin.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MetasFinWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
