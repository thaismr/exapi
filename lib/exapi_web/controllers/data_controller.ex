defmodule ExapiWeb.DataController do
  use ExapiWeb, :controller

  alias ExapiWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def show(conn, params) do
    with {:ok, data} <- Exapi.github_data(params),
         token <- Guardian.get_token(conn) do
      conn
      |> put_status(:ok)
      |> render("data.json", data: data, token: token)
    end
  end

  def index(conn, _params) do
    conn
    |> put_status(:no_content)
    |> text("")
  end
end
