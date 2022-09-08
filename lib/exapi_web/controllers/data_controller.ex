defmodule ExapiWeb.DataController do
  use ExapiWeb, :controller

  action_fallback ExapiWeb.FallbackController

  def show(conn, params) do
    with {:ok, data} <- Exapi.github_data(params) do
      conn
      |> put_status(:ok)
      |> render("data.json", data: data)
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(:no_content)
    |> text("")
  end
end
