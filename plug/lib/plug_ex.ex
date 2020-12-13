defmodule PlugEx do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: PlugEx.Router, options: [port: 8000]}
    ]

    Logger.info("App Started!")

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
