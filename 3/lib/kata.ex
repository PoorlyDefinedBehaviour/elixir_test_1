defmodule Calculator do
  @spec start :: pid
  def start do
    spawn(fn -> loop(0) end)
  end

  defp loop(current_value) do
    new_value =
      receive do
        {:value, client_id} ->
          send(client_id, {:response, current_value})
          current_value

        {:add, value} ->
          current_value + value

        {:sub, value} ->
          current_value - value

        {:mult, value} ->
          current_value * value

        {:div, value} ->
          current_value / value

        invalid_request ->
          IO.puts("Invalid request #{inspect(invalid_request)}")
      end

    loop(new_value)
  end

  @spec value(atom | pid | port | {atom, atom}) :: number()
  def value(server_id) do
    send(server_id, {:value, self()})

    receive do
      {:response, value} -> value
    end
  end

  @spec add(atom | pid | port | {atom, atom}, number()) :: any
  def add(server_id, value) do
    send(server_id, {:add, value})
    value(server_id)
  end

  @spec sub(atom | pid | port | {atom, atom}, number()) :: any
  def sub(server_id, value) do
    send(server_id, {:sub, value})
    value(server_id)
  end

  @spec mult(atom | pid | port | {atom, atom}, number()) :: any
  def mult(server_id, value) do
    send(server_id, {:mult, value})
    value(server_id)
  end

  @spec div(atom | pid | port | {atom, atom}, number()) :: any
  def div(server_id, value) do
    send(server_id, {:div, value})
    value(server_id)
  end
end
