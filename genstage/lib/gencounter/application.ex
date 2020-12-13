defmodule Gencounter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Gencounter.Worker.start_link(arg)
      # {Gencounter.Worker, arg}
      {Gencounter.Producer, 0},
      {Gencounter.ProducerConsumer, []},
      %{id: :a, start: {Gencounter.Consumer, :start_link, [[]]}},
      %{id: :b, start: {Gencounter.Consumer, :start_link, [[]]}},
      %{id: :c, start: {Gencounter.Consumer, :start_link, [[]]}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Gencounter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
