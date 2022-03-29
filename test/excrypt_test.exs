defmodule ExcryptTest do
  use ExUnit.Case
  doctest Excrypt

  test "greets the world" do
    assert Excrypt.hello() == :world
  end
end
