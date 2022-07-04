defmodule Banter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Banter.Repo,
      # Start the Telemetry supervisor
      BanterWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Banter.PubSub},
      # Start the Endpoint (http/https)
      BanterWeb.Endpoint
      # Start a worker by calling: Banter.Worker.start_link(arg)
      # {Banter.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Banter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BanterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
