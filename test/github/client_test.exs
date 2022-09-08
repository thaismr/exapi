defmodule Exapi.Github.ClientTest do
  @moduledoc """
  Uses Bypass to test the Github Client
  https://github.com/PSPDFKit-labs/bypass
  """
  use ExUnit.Case, async: true

  alias Exapi.Error
  alias Exapi.Github.{Client, Response}
  alias Github.Support.GithubFixture

  describe "get_user_repos/2" do
    setup do
      bypass = Bypass.open()

      {:ok, bypass: bypass}
    end

    test "when there is a valid user, returns the repo info", %{bypass: bypass} do
      username = "12345"

      url = endpoint_url(bypass.port)

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(200, GithubFixture.body())
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {
        :ok,
        [
          %Response{
            description: nil,
            html_url: "https://github.com/12345/12345.github.io",
            id: 173_204_968,
            name: "12345.github.io",
            stargazers_count: 0
          },
          %Response{
            description: "memo",
            html_url: "https://github.com/12345/test",
            id: 91_750_966,
            name: "test",
            stargazers_count: 0
          },
          %Response{
            description: "Play Framework Documentation Japanese Translation",
            html_url: "https://github.com/12345/translation-project",
            id: 92_003_687,
            name: "translation-project",
            stargazers_count: 0
          }
        ]
      }

      assert response == expected_response
    end

    test "when the username was not found, returns an error", %{bypass: bypass} do
      username = "_"

      url = endpoint_url(bypass.port)

      body = ~s({
          "message": "Not Found",
          "documentation_url": "https://docs.github.com/rest/reference/repos#list-repositories-for-a-user"
        })

      Bypass.expect(bypass, "GET", "#{username}/repos", fn conn ->
        conn
        |> Plug.Conn.put_resp_header("content-type", "application/json")
        |> Plug.Conn.resp(404, body)
      end)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, %Error{result: "Github user not found!", status: :not_found}}

      assert response == expected_response
    end

    test "when there is a connection error, returns an error", %{bypass: bypass} do
      username = "12345"

      url = endpoint_url(bypass.port)

      Bypass.down(bypass)

      response = Client.get_user_repos(url, username)

      expected_response = {:error, %Error{result: :econnrefused, status: :bad_request}}

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}/"
  end
end
