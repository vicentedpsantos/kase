defmodule Kase.Plug.ConvertKeysTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Kase.Plug.ConvertKeys

  test "when request casing is provided, converts incoming params" do
    params = %{
      "firstParam" => "first",
      "SecondParam" => "second",
      "nestedParam" => %{
        "innerParam" => "inner"
      }
    }

    conn =
      :get
      |> conn("/test", params)
      |> ConvertKeys.call(request_casing: :cobol_case)

    assert conn.params == %{
             "FIRST-PARAM" => "first",
             "SECOND-PARAM" => "second",
             "NESTED-PARAM" => %{"INNER-PARAM" => "inner"}
           }
  end

  test "when request casing is not provided, defaults to converting to snake case" do
    params = %{
      "first.param" => "first",
      "second.param" => "second",
      "nested.param" => %{
        "inner.param" => "inner"
      }
    }

    conn =
      :get
      |> conn("/test", params)
      |> ConvertKeys.call()

    assert conn.params == %{
             "first_param" => "first",
             "second_param" => "second",
             "nested_param" => %{"inner_param" => "inner"}
           }
  end

  test "when response casing is provided, converts outgoing params to COBOL case" do
    response_params = %{
      "first_param" => "first",
      "second_param" => "second",
      "nested_param" => %{
        "inner_param" => "inner"
      }
    }

    # Here we simulate the response in a normal plug pipeline
    conn =
      :get
      |> conn("/test", %{})
      |> Plug.Conn.put_resp_content_type("application/json")
      |> ConvertKeys.call(response_casing: :cobol_case)

    # We manually set the response body after applying the response casing
    conn = Plug.Conn.send_resp(conn, 200, Jason.encode!(response_params))

    # Decode the response body for assertion
    decoded_response = Jason.decode!(conn.resp_body)

    assert decoded_response == %{
             "FIRST-PARAM" => "first",
             "SECOND-PARAM" => "second",
             "NESTED-PARAM" => %{"INNER-PARAM" => "inner"}
           }
  end

  test "when response casing is not provided, defaults to converting to snake_case" do
    response_params = %{
      "firstParam" => "first",
      "secondParam" => "second",
      "nestedParam" => %{
        "innerParam" => "inner"
      }
    }

    conn =
      :get
      |> conn("/test", %{})
      |> Plug.Conn.put_resp_content_type("application/json")
      |> ConvertKeys.call()

    # Manually set the response body after applying the response casing
    conn = Plug.Conn.send_resp(conn, 200, Jason.encode!(response_params))

    # Decode the response body for assertion
    decoded_response = Jason.decode!(conn.resp_body)

    assert decoded_response == %{
             "first_param" => "first",
             "second_param" => "second",
             "nested_param" => %{"inner_param" => "inner"}
           }
  end
end
