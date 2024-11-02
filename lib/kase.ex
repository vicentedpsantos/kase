defmodule Kase do
  @moduledoc """
  A module for converting strings between different casing styles.
  """

  alias Kase.Conversor

  @typedoc "The target case to convert the string to."
  @type target_case ::
          :camel_case
          | :cobol_case
          | :dot_case
          | :flat_case
          | :humanized_case
          | :kebab_case
          | :pascal_case
          | :snake_case
          | :train_case
          | :upper_case_snake_case

  @doc """
  Converts a given `string` to the specified `target_case`.

  ## Examples

      iex> Kase.convert("this-variable-name", :camel_case)
      "thisVariableName"

      iex> Kase.convert(["kool-aid, "royalCrown"], :snake_case)
      ["kool_aid", "royal_crown"]

  """

  @spec convert(String.t() | [String.t()], target_case()) :: String.t()
  def convert(list, target_case) when is_list(list),
    do: Enum.map(list, &Conversor.convert(&1, target_case))

  def convert(string, target_case) when is_binary(string),
    do: Conversor.convert(string, target_case)

  @doc """
  Converts the keys of a given `map` to the specified `target_case`.

  ## Examples

      map_input = %{"first_key" => "value", "second_key" => "value", "nested_value" => %{"inner_key" => "value"}}
      iex> Kase.convert(map_input, :camel_case)
      %{"firstKey" => "value", "secondKey" => "value", "nestedValue" => %{"innerKey" => "value"}}

      map_input = %{"first_key" => "value", "second_key" => "value"}
      iex> Kase.convert(map_input, :camel_case, to_atoms: true)
      %{"firstKey": "value", "secondKey": "value"}

  """
  @spec convert(map(), target_case(), Keyword.t()) :: map()
  def convert(%{} = map, target_case, options \\ []) do
    to_atoms = Keyword.get(options, :to_atoms, false)

    map
    |> Map.new(fn {key, value} ->
      new_key = Conversor.convert(to_string(key), target_case)

      new_value =
        case value do
          %{} -> convert(value, target_case, options)
          _ -> value
        end

      if to_atoms do
        {String.to_atom(new_key), new_value}
      else
        {new_key, new_value}
      end
    end)
  end

  @doc """
  Compares two strings for equality, ignoring casing differences.

  ## Examples

      iex> Kase.case_invariant_equal?("helloWorld", "hello_world")
      true

      iex> Kase.case_invariant_equal?("fooBar", "FOO_BAR")
      true

      iex> Kase.case_invariant_equal?("KaseLib", "case_lib")
      false

  """
  def case_invariant_equal?(string1, string2) do
    Conversor.convert(string1, :dot_case) == Conversor.convert(string2, :dot_case)
  end

  @spec supported_casing_styles() :: [target_case()]
  def supported_casing_styles do
    [
      :camel_case,
      :cobol_case,
      :dot_case,
      :flat_case,
      :humanized_case,
      :kebab_case,
      :pascal_case,
      :snake_case,
      :train_case,
      :upper_case_snake_case
    ]
  end
end
