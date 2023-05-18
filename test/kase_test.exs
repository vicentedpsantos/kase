defmodule KaseTest do
  use ExUnit.Case
  doctest Kase

  test "greets the world" do
    assert Kase.hello() == :world
  end
end
