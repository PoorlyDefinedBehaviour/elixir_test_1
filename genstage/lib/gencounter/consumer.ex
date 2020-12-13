defmodule Gencounter.Consumer do
  use GenStage

  def start_link(initial_value) do
    GenStage.start_link(__MODULE__, initial_value)
  end

  def init(state) do
    {:consumer, state, subscribe_to: [Gencounter.ProducerConsumer]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect({self(), event, state})
    end

    {:noreply, [], state}
  end
end
