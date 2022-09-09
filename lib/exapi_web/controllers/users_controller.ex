defmodule ExapiWeb.UsersController do
  use ExapiWeb, :controller

  alias Exapi.User
  alias ExapiWeb.{Auth.Guardian, FallbackController}

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Exapi.create_user(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("create.json", %{token: token, user: user})
    end
  end
end
