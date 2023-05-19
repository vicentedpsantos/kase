defmodule Kase.Identifier do
  @moduledoc """
  Identifies which casing input is typed in. Results can be one of
  the following:
  - Text Case
  - Camel Case
  - Snake Case
  - Kebab Case
  - Pascal Case
  """

  @dash "-"
  @underscore "_"
  @empty " "

  @forbidden_for_camel_case [@empty, @dash, @underscore]
  @forbidden_for_kebab_case [@empty, @underscore]

  @spec camel_case?(String.t()) :: boolean()
  def camel_case?(input) do
    downcase?(String.first(input)) &&
      !contains_forbidden_characters?(input, @forbidden_for_camel_case) &&
      at_least_one_upcase_letter?(input)
  end

  @spec kebab_case?(String.t()) :: boolean()
  def kebab_case?(input) do
    !contains_forbidden_characters?(input, @forbidden_for_kebab_case) &&
      at_least_one_of?(input, @dash)
  end

  @spec contains_forbidden_characters?(String.t(), [String.t()]) :: boolean()
  defp contains_forbidden_characters?(input, forbidden_characters_list) do
    input
    |> String.split("", trim: true)
    |> Enum.any?(&(&1 in forbidden_characters_list))
  end

  @spec downcase?(String.t()) :: boolean()
  defp downcase?(input), do: String.downcase(input) == input

  @spec upcase?(String.t()) :: boolean()
  defp upcase?(input), do: String.upcase(input) == input

  @spec at_least_one_upcase_letter?(String.t()) :: boolean()
  defp at_least_one_upcase_letter?(input) do
    input
    |> String.split("", trim: true)
    |> Enum.any?(&upcase?(&1))
  end

  @spec at_least_one_of?(String.t(), String.t()) :: boolean()
  defp at_least_one_of?(input, symbol) do
    input
    |> String.split("", trim: true)
    |> Enum.any?(&(&1 == symbol))
  end
end
