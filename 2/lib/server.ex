defmodule Chat.Server do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: :chat_room)
  end

  def get_messages do
    GenServer.call(:chat_room, :get_msgs)
  end

  def add_message(message) do
    GenServer.cast(:chat_room, {:add_message, message})
  end

  @impl true
  def init(messages) do
    {:ok, messages}
  end

  @impl true
  def handle_call(:get_msgs, _from, messages) do
    {:reply, messages, messages}
  end

  @impl true
  def handle_cast({:add_message, message}, messages) do
    {:noreply, [message | messages]}
  end
end
