defmodule Kase.IdentifierTest do
  use ExUnit.Case, async: true

  doctest Kase.Identifier

  alias Kase.Identifier, as: Subject

  describe "is_camel_case?/1" do
    [
      {"firstName", true},
      {"first_name", false},
      {"first name", false},
      {"FirstName", false},
      {"FIRSTNAME", false},
      {"firstname", false},
      {"first-name", false},
      {"First Name", false},
      {"fIRST nAME", false},
      {"f i r s t n a m e", false},
      {"F I R S T N A M E", false},
      {"FIRST-NAME", false},
      {"FIRST_NAME", false}
    ]
    |> Enum.each(fn {input, expected_result} ->
      test "when input is #{input}, returns #{expected_result}" do
        assert Subject.is_camel_case?(unquote(input)) == unquote(expected_result)
      end
    end)
  end
end
