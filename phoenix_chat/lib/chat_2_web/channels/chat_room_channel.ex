defmodule Chat2Web.ChatRoomChannel do
  use Chat2Web, :channel

  @impl true
  def join("chat_room:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (chat_room:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    spawn(fn -> save_message(payload) end)
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    Chat2.Message.get_messages()
    |> Enum.each(&push(socket, "shout", %{name: &1.name, message: &1.message}))

    {:noreply, socket}
  end

  defp save_message(message) do
    Chat2.Message.changeset(%Chat2.Message{}, message)
    |> Chat2.Repo.insert()
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
