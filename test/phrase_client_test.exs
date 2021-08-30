defmodule PhraseClientTest do
  use ExUnit.Case
  doctest PhraseClient

  test "greets the world" do
    assert PhraseClient.hello() == :world
  end
end
