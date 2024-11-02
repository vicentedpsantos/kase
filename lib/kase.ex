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

      iex> Kase.convert("ThisIsPascalCase", :snake_case)
      "this_is_pascal_case"

      map_input = %{"first_key" => "value", "second_key" => "value"}
      iex> Kase.convert(map_input, :camel_case)
      %{"firstKey" => "value", "secondKey" => "value"}

  """

  @spec convert(String.t(), target_case()) :: String.t()
  def convert(string, target_case) when is_binary(string),
    do: Conversor.convert(string, target_case)

  @spec convert(map(), target_case(), Keyword.t()) :: map()
  def convert(%{} = map, target_case, options \\ []) do
    to_atoms = Keyword.get(options, :to_atoms, false)

    map
    |> Map.new(fn {key, value} ->
      new_key = Conversor.convert(to_string(key), target_case)

      if to_atoms do
        {String.to_atom(new_key), value}
      else
        {new_key, value}
      end
    end)
  end
end
