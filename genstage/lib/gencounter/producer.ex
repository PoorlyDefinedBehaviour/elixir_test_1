defmodule Gencounter.Producer do
  use GenStage

  @spec start_link(integer) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(initial_value \\ 0) do
    GenStage.start_link(__MODULE__, initial_value, name: __MODULE__)
  end

  @spec init(integer) :: {:producer, integer}
  def init(counter), do: {:producer, counter}

  @spec handle_demand(integer, integer) :: {:noreply, [integer], integer}
  def handle_demand(demand, state) do
    events = Enum.to_list(state..(state + demand - 1))

    {:noreply, events, state + demand}
  end
end
