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

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Exapi.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def sign_in(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
