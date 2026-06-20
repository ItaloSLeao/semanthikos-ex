defmodule EventManager.Application do
  @moduledoc """
  Main application module that starts and supervises all processes.
  Uses the Application behaviour for OTP compliance.
  """
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Database repository
      EventManager.Repo,
      # Telemetry for metrics collection
      EventManagerWeb.Telemetry,
      # PubSub for real-time communication
      {Phoenix.PubSub, name: EventManager.PubSub},
      # Presence tracking for live features
      EventManagerWeb.Presence,
      # Web endpoint
      EventManagerWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: EventManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    EventManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
