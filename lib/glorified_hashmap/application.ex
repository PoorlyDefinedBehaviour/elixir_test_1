defmodule GlorifiedHashmap.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    IO.puts(Application.get_env(:glorified_hashmap, :port))

    children = [
      # Starts a worker by calling: GlorifiedHashmap.Worker.start_link(arg)
      # {GlorifiedHashmap.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: GlorifiedHashmap.Endpoint, options: [port: 4001]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GlorifiedHashmap.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
