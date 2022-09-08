defmodule Exapi.Github.Client do
  @moduledoc """
  Client for consuming the external Github API
  """
  use Tesla

  alias Exapi.Error
  alias Exapi.Github.Response
  alias Tesla.Env

  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Headers, [{"user-agent", "Tesla"}]

  @base_url "https://api.github.com/users/"

  def get_user_repos(url \\ @base_url, username) do
    "#{url}#{username}/repos"
    |> get
    |> handle_get
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end

  defp handle_get({:ok, %Env{status: 404, body: %{"message" => "Not Found"}}}) do
    {:error, Error.build(:not_found, "Github user not found!")}
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, Enum.map(body, &Response.build_response/1)}
  end
end
