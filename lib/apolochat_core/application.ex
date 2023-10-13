defmodule ApolochatCore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      ApolochatCoreWeb.Telemetry,
      # Start the Ecto repository
      ApolochatCore.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: ApolochatCore.PubSub},
      # Start Finch
      {Finch, name: ApolochatCore.Finch},
      # Start the Endpoint (http/https)
      ApolochatCoreWeb.Endpoint
      # Start a worker by calling: ApolochatCore.Worker.start_link(arg)
      # {ApolochatCore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApolochatCore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApolochatCoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
