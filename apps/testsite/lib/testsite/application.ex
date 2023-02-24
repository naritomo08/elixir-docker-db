defmodule Testsite.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Testsite.Repo,
      # Start the Telemetry supervisor
      TestsiteWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Testsite.PubSub},
      # Start the Endpoint (http/https)
      TestsiteWeb.Endpoint
      # Start a worker by calling: Testsite.Worker.start_link(arg)
      # {Testsite.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Testsite.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TestsiteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
