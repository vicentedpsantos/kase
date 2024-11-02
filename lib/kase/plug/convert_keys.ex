defmodule Kase.Plug.ConvertKeys do
  @moduledoc """
  A Plug for converting the casing of request and response keys.

  This plug allows you to convert the keys of incoming JSON requests
  and outgoing JSON responses to various casing styles such as
  `snake_case`, `camelCase`, `PascalCase`, etc.

  ## Usage

  To use this plug, you can either add it to your router or directly
  in a controller.

  ### In Your Router

  You can use the plug in your router to apply it to specific routes or
  all routes. Here's how you can do that:

  ```elixir
    defmodule MyAppWeb.Router do
      use MyAppWeb, :router

      pipeline :api do
        plug Kase.Plug.ConvertKeys
      end

      scope "/api", MyAppWeb do
        pipe_through :api

        get "/example", ExampleController, :index
      end
    end
  ```

  ### In a Controller

  ```elixir
    defmodule MyAppWeb.ExampleController do
      use MyAppWeb, :controller
      plug Kase.Plug.ConvertKeys

      def index(conn, _params) do
        json(conn, %{some_key: "some_value"})
      end
    end
  ```

  ### Options

  The plug accepts the following options:

    - :request_casing - Specify the casing for incoming request parameters.
      Accepted values include :snake_case, :camel_case, :pascal_case, etc.
      Defaults to :snake_case.
    - :response_casing - Specify the casing for outgoing response
      parameters. Similar to :request_casing, it accepts the same casing
      styles and defaults to :snake_case.

  #### Example of using Options

  Here’s an example of how to specify request and response casing options:

  ```elixir
    defmodule MyAppWeb.ExampleController do
      use MyAppWeb, :controller
      plug Kase.Plug.ConvertKeys, request_casing: :dot_case, response_casing: :train_case

      def index(conn, _params) do
        json(conn, %{"exampleKey" => "exampleValue"})
      end
    end
  ```

  In this example, incoming parameters will be converted to camelCase, and outgoing
  responses will be in PascalCase.

  """

  import Plug.Conn

  @default_casing :snake_case
  @supported_casing_styles Kase.supported_casing_styles()

  @doc """
  Initializes the plug.
  """
  def init(opts) do
    opts
  end

  @doc """
  Converts the keys of the request body to the desired casing style.
  """
  def call(conn, opts \\ []) do
    request_casing = Keyword.get(opts, :request_casing, @default_casing)
    response_casing = Keyword.get(opts, :response_casing, @default_casing)

    conn
    |> convert_request_keys(request_casing)
    |> register_before_send(&convert_response_keys(&1, response_casing))
  end

  # Convert keys in incoming JSON requests
  defp convert_request_keys(%{params: params} = conn, request_casing)
       when request_casing in @supported_casing_styles do
    converted_params = Kase.convert(params, request_casing)
    %{conn | params: converted_params}
  end

  defp convert_request_keys(conn, _request_casing), do: conn

  defp convert_response_keys(%{resp_body: body, resp_headers: headers} = conn, response_casing)
       when response_casing in @supported_casing_styles do
    if json_response?(headers) do
      converted_body = body |> Jason.decode!() |> Kase.convert(response_casing) |> Jason.encode!()
      put_resp_content_type(conn, "application/json")
      %{conn | resp_body: converted_body}
    else
      conn
    end
  end

  defp convert_response_keys(conn, _response_casing), do: conn

  defp json_response?(headers) do
    headers
    |> Enum.any?(fn {key, value} ->
      key == "content-type" && String.contains?(value, "application/json")
    end)
  end
end
