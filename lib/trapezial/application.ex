defmodule Trapezial.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TrapezialWeb.Telemetry,
      Trapezial.Repo,
      {DNSCluster, query: Application.get_env(:trapezial, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Trapezial.PubSub},
      # Start a worker by calling: Trapezial.Worker.start_link(arg)
      # {Trapezial.Worker, arg},
      # Start to serve requests, typically the last entry
      TrapezialWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Trapezial.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TrapezialWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
