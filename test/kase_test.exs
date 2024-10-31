defmodule KaseTest do
  @moduledoc false

  use ExUnit.Case
  # doctest Kase

  describe "Kase.convert/2 when input is a map" do
    test "converts keys to the specified target case" do
      map_input = %{"first_key" => "value", "second_key" => "value"}

      expected_output = %{"firstKey" => "value", "secondKey" => "value"}

      assert Kase.convert(map_input, :camel_case) == expected_output
    end

    test "when `to_atoms` option is true" do
      map_input = %{"first_key" => "value", "second_key" => "value"}
      expected_output = %{:"first-key" => "value", :"second-key" => "value"}

      assert Kase.convert(map_input, :kebab_case, to_atoms: true) == expected_output
    end
  end
end
