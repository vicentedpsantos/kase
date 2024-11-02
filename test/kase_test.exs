defmodule KaseTest do
  @moduledoc false

  use ExUnit.Case
  # doctest Kase

  describe "Kase.convert/3 when input is a map" do
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

  describe "Kase.convert/2 when input is a list" do
    test "converts each element to the specified target case" do
      list_input = ["this-variable-name", "ThisIsPascalCase"]

      expected_output = ["this_variable_name", "this_is_pascal_case"]

      assert Kase.convert(list_input, :snake_case) == expected_output
    end
  end

  describe "case_invariant_equal?/2" do
    test "returns true when strings are equal regardless of case" do
      assert Kase.case_invariant_equal?("CORK-BAIS", "cork.bais")
    end

    test "returns false when strings are not equal" do
      refute Kase.case_invariant_equal?("the-state-of-ye", "the-state-of-me")
    end
  end
end
