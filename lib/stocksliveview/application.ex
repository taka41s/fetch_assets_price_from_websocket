defmodule Stocksliveview.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    Dotenv.load
    Mix.Task.run("loadconfig")
    children = [
      # Start the Ecto repository
      Stocksliveview.Repo,
      {Phoenix.PubSub, name: :assets},
      Stocksliveview.Websocket,
      # Start the Telemetry supervisor
      StocksliveviewWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Stocksliveview.PubSub},
      # Start the Endpoint (http/https)
      StocksliveviewWeb.Endpoint
      # Start a worker by calling: Stocksliveview.Worker.start_link(arg)
      # {Stocksliveview.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Stocksliveview.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    StocksliveviewWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
