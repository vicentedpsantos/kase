# Käse

[![Kase Package](https://img.shields.io/hexpm/v/kase.svg)](https://hex.pm/packages/kase/1.0.0)

Käse is an Elixir library for converting strings between various casing styles, including
camelCase, snake_case, kebab-case, PascalCase, and more. Whether you're working with data from
different sources or simply want to format strings in a specific way, Käse provides a
straightforward API to handle these conversions.

## Installation

To use Käse in your Elixir project, add it to your `mix.exs` file:

```elixir
defp deps do
  [
    {:kase, "~> 1.0.0"}
  ]
end
```

Then run the following command to install the dependency:

```bash
mix deps.get
```

## Usage

You can convert strings between different casing styles using the `Kase.convert/2` function.
Here are some examples:

### Convert to camelCase

```elixir
Kase.convert("this_is_an_example", :camel_case)
# => "thisIsAnExample"

Kase.convert("ThisIsPascalCase", :camel_case)
# => "thisIsPascalCase"
```

### Convert to snake_case

```elixir
Kase.convert("thisIsAnExample", :snake_case)
# => "this_is_an_example"

Kase.convert("ThisIsPascalCase", :snake_case)
# => "this_is_pascal_case"
```

### Convert to kebab-case

```elixir
Kase.convert("thisIsAnExample", :kebab_case)
# => "this-is-an-example"

Kase.convert("ThisIsPascalCase", :kebab_case)
# => "this-is-pascal-case"
```

### Convert to PascalCase

```elixir
Kase.convert("this_is_an_example", :pascal_case)
# => "ThisIsAnExample"

Kase.convert("this-is-an-example", :pascal_case)
# => "ThisIsAnExample"
```

### Convert to upper_case_snake_case

```elixir
Kase.convert("thisIsAnExample", :upper_case_snake_case)
# => "THIS_IS_AN_EXAMPLE"
```

### Convert to train-case

```elixir
Kase.convert("thisIsAnExample", :train_case)
# => "This-Is-An-Example"
```

### Convert to dot.case

```elixir
Kase.convert("thisIsAnExample", :dot_case)
# => "this.is.an.example"
```

### Convert to cobol-case

```elixir
Kase.convert("thisIsAnExample", :cobol_case)
# => "THIS-IS-AN-EXAMPLE"
```

### Convert to humanized case

```elixir
Kase.convert("this_is_an_example", :humanized_case)
# => "This is an example"
```

### Convert to flat case

```elixir
Kase.convert("this_is_an_example", :flat_case)
# => "thisisanexample"
```

### Convert Map Keys
You can also convert the keys of a map to a desired casing style using Kase.convert/3. This
function accepts an optional :to_atoms option to convert the keys into atoms if desired.


```elixir
original_map = %{first_name: "John", last_name: "Doe"}
Kase.convert(original_map, :kebab_case)
# => %{"first-name" => "John", "last-name" => "Doe"}
```

#### Convert with keys as atoms
```elixir
Kase.convert(original_map, :kebab_case, to_atoms: true)
# => %{"first-name": "John", "last-name": "Doe"}
```

## Plug for Key Conversion

Käse also provides a Plug for automatically converting the keys of incoming request parameters
and outgoing response data to different casing styles. This is particularly useful in a
Phoenix application where you want consistent casing for API inputs and outputs. Both request
and response casing styles default to `:snake_case`.

### Usage

You can add the plug to your router or directly in a controller. 
Here’s an example of how to use it:

```elixir
defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug Kase.Plug.ConvertKeys, request_casing: :flat_case, response_casing: :train_case
  end

  scope "/api", MyAppWeb do
    pipe_through :api

    get "/example", ExampleController, :index
  end
end
```


## Contributing

Contributions are welcome! If you have suggestions for improvements or find bugs, please open
an issue or submit a pull request.

1. Fork the project
2. Create your feature branch: `git checkout -b feature/my-new-feature`
3. Commit your changes: `git commit -m 'Add some feature'`
4. Push to the branch: `git push origin feature/my-new-feature`
5. Open a pull request

## License

Käse is released under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Acknowledgments

Thank you for using Käse! We hope it helps make your string handling in Elixir easier and more
enjoyable.
