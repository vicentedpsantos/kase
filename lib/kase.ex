defmodule Kase do
  @moduledoc """
  A module for converting strings and map keys between various casing styles.

  Käse simplifies the process of converting strings and map keys to different
  casing formats, such as camelCase, snake_case, kebab-case, and more. This is
  especially useful when working with APIs or data transformations, where consistent
  casing is important.

  ## Features

    - Convert strings to a specified casing style.
    - Convert lists of strings to a specified casing style.
    - Convert map keys to a specified casing style, including nested maps.
    - Case-invariant string comparisons.
    - Supports a wide variety of casing styles.

  ## Usage

  ### String Conversion

  Convert a single string to a specified casing style:

      iex> Kase.convert("this-variable-name", :camel_case)
      "thisVariableName"

  Convert a list of strings to a specified casing style:

      iex> Kase.convert(["kool-aid", "royalCrown"], :snake_case)
      ["kool_aid", "royal_crown"]

  ### Map Key Conversion

  Convert the keys of a map to a specified casing style. This also supports nested
  maps and the option to convert keys to atoms:

      iex> map_input = %{"first_key" => "value", "second_key" => "value", "nested_value" => %{"inner_key" => "value"}}
      iex> Kase.convert(map_input, :camel_case)
      %{"firstKey" => "value", "secondKey" => "value", "nestedValue" => %{"innerKey" => "value"}}

      iex> Kase.convert(map_input, :camel_case, to_atoms: true)
      %{"firstKey": "value", "secondKey": "value", "nestedValue": %{"innerKey": "value"}}

  ### Case-Invariant Comparison

  Compare two strings for equality, ignoring differences in casing:

      iex> Kase.case_invariant_equal?("helloWorld", "hello_world")
      true

      iex> Kase.case_invariant_equal?("fooBar", "FOO_BAR")
      true

  ## Supported Casing Styles

  The following casing styles are supported:

    - :camel_case - camelCase
    - :cobol_case - COBOL-CASE
    - :dot_case - dot.case
    - :flat_case - flatcase
    - :humanized_case - Humanized case
    - :kebab_case - kebab-case
    - :pascal_case - PascalCase
    - :snake_case - snake_case
    - :train_case - Train-Case
    - :upper_case_snake_case - UPPER_CASE_SNAKE_CASE

  For any custom conversions or additional casing styles, the `Kase.Conversor`
  module can be extended to handle these cases.

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

      iex> Kase.convert(["kool-aid", "royalCrown"], :snake_case)
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
  @spec case_invariant_equal?(String.t(), String.t()) :: boolean()
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
