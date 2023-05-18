defmodule Kase do
  @moduledoc """
  Public interface for modules defined for each casing.
  - Camel Case
  - Snake Case
  - Kebab Case
  - Pascal Case
  """

  alias Kase.Camel

  @doc """
  Converts a string to camel case.

  ## Examples

      iex> Kase.camel("John Smith")
      "john_smith"

  """
  defdelegate camel(input), to: Camel
end
