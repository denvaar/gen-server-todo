defmodule GenServerTodoTest do
  use ExUnit.Case
  doctest GenServerTodo

  test "greets the world" do
    assert GenServerTodo.hello() == :world
  end
end
