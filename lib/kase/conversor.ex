defmodule Kase.Conversor do
  @moduledoc """
  A module for converting strings between different casing styles.
  """

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

      iex> Kase.convert("THIS-IS-COBOL-CASE", :humanized_case)
      "This is cobol case"

      iex> Kase.convert("this-variable-name", :camel_case)
      "thisVariableName"

      iex> Kase.convert("ThisIsPascalCase", :snake_case)
      "this_is_pascal_case"

      iex> Kase.convert("snake_case_var", :kebab_case)
      "snake-case-var"

      iex> Kase.convert("PascalCaseVar", :upper_case_snake_case)
      "PASCAL_CASE_VAR"

      iex> Kase.convert("this-is-an-example", :train_case)
      "This-Is-An-Example"

      iex> Kase.convert("this_is_cobol_case", :cobol_case)
      "THIS-IS-COBOL-CASE"

      iex> Kase.convert("exampleForDotCase", :dot_case)
      "example.for.dot.case"

  ## Supported target cases

  - `:camel_case`
  - `:cobol_case`
  - `:dot_case`
  - `:flat_case`
  - `:humanized_case`
  - `:kebab_case`
  - `:pascal_case`
  - `:snake_case`
  - `:train_case`
  - `:upper_case_snake_case`

  """

  @spec convert(String.t() | map(), target_case()) :: String.t()
  def convert(string, target_case) when is_binary(string) do
    dot_cased_string = to_dot_case(string)

    case target_case do
      :camel_case -> from_dot_case_to_camel_case(dot_cased_string)
      :cobol_case -> from_dot_case_to_cobol_case(dot_cased_string)
      :flat_case -> from_dot_case_to_flat_case(dot_cased_string)
      :humanized_case -> from_dot_case_to_humanized_case(dot_cased_string)
      :kebab_case -> from_dot_case_to_kebab_case(dot_cased_string)
      :pascal_case -> from_dot_case_to_pascal_case(dot_cased_string)
      :snake_case -> from_dot_case_to_snake_case(dot_cased_string)
      :train_case -> from_dot_case_to_train_case(dot_cased_string)
      :upper_case_snake_case -> from_dot_case_to_upper_case_snake_case(dot_cased_string)
      # Added this line for dot_case conversion
      :dot_case -> dot_cased_string
      _ -> string
    end
  end

  @spec from_dot_case_to_camel_case(String.t()) :: String.t()
  defp from_dot_case_to_camel_case(string) do
    string
    |> String.split(".")
    |> Enum.with_index()
    |> Enum.map(fn
      # First word is lowercase
      {word, 0} -> String.downcase(word)
      # Subsequent words are capitalized
      {word, _index} -> String.capitalize(word)
    end)
    |> Enum.join()
  end

  @spec from_dot_case_to_cobol_case(String.t()) :: String.t()
  defp from_dot_case_to_cobol_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.upcase/1)
    |> Enum.join("-")
  end

  @spec from_dot_case_to_flat_case(String.t()) :: String.t()
  def from_dot_case_to_flat_case(string) do
    string
    |> String.split(".")
    |> Enum.join("")
  end

  @spec from_dot_case_to_humanized_case(String.t()) :: String.t()
  defp from_dot_case_to_humanized_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.downcase/1)
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(" ")
  end

  @spec from_dot_case_to_kebab_case(String.t()) :: String.t()
  defp from_dot_case_to_kebab_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.downcase/1)
    |> Enum.join("-")
  end

  @spec from_dot_case_to_pascal_case(String.t()) :: String.t()
  defp from_dot_case_to_pascal_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join()
  end

  @spec from_dot_case_to_snake_case(String.t()) :: String.t()
  defp from_dot_case_to_snake_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.downcase/1)
    |> Enum.join("_")
  end

  @spec from_dot_case_to_train_case(String.t()) :: String.t()
  defp from_dot_case_to_train_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.capitalize/1)
    |> Enum.join("-")
  end

  @spec from_dot_case_to_upper_case_snake_case(String.t()) :: String.t()
  defp from_dot_case_to_upper_case_snake_case(string) do
    string
    |> String.split(".")
    |> Enum.map(&String.upcase/1)
    |> Enum.join("_")
  end

  @spec to_dot_case(String.t()) :: String.t()
  defp to_dot_case(string) do
    string
    |> split_words()
    |> Enum.map(&String.downcase/1)
    |> Enum.join(".")
  end

  defp split_words(string) do
    string
    # Split lower to upper case
    |> String.replace(~r/([a-z])([A-Z])/, "\\1 \\2")
    # Split consecutive uppercase
    |> String.replace(~r/([A-Z])([A-Z][a-z])/, "\\1 \\2")
    # Replace other separators
    |> String.replace(~r/[_\-\.\s]+/, " ")
    # Split into words
    |> String.split(" ", trim: true)
  end
end
