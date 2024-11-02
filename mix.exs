defmodule Kase.MixProject do
  use Mix.Project

  def project do
    [
      app: :kase,
      version: "1.0.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: [
        main: "Kase",
        extras: ["README.md", "LICENSE"]
      ],
      description: "A module for converting strings between different casing styles.",
      package: package_info()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp package_info do
    [
      files: ["lib", "mix.exs", "README.md", "LICENSE"],
      licenses: ["MIT"],
      maintainers: ["Vicente Santos"],
      links: %{"GitHub" => "https://github.com/vicentedpsantos/kase"}
    ]
  end
end
