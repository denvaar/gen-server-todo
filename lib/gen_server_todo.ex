defmodule GenServerTodo do
  @moduledoc """
  A sweet todo list to explore the basics of GenServer.
  """
  use GenServer

  # Client API

  @doc """
  """
  def start_link, do: GenServer.start_link(__MODULE__, :ok, [])

  def display(pid), do: GenServer.call(pid, {:display})

  def add_item(pid, item_name), do: GenServer.cast(pid, {:add, item_name})

  def remove_item(pid, index), do: GenServer.cast(pid, {:remove, index})

  def mark_item_completed(pid, index), do: GenServer.cast(pid, {:mark_complete, index})

  # Server callbacks

  def init(:ok), do: {:ok, []}

  def handle_call({:display}, _from, items), do: {:reply, items, items}

  def handle_cast({:add, item_name}, items), do: {:noreply, items ++ [%{name: item_name, completed?: false}]}
  def handle_cast({:remove, item_index}, items), do: {:noreply, List.delete_at(items, item_index)}

  def handle_cast({:mark_complete, item_index}, items) do
    completed_item =
      items
      |> Enum.at(item_index)
      |> Map.replace!(:completed?, true)

    {:noreply,
      items
      |> List.replace_at(item_index, completed_item)}
  end
end
