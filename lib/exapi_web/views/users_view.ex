defmodule ExapiWeb.UsersView do
  use ExapiWeb, :view

  alias Exapi.User

  def render("create.json", %{token: token, user: %User{id: id}}) do
    %{
      token: token,
      user: %User{
        id: id
      }
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end

  def render("user.json", %{user: %User{id: id}}) do
    %{
      user: %User{
        id: id
      }
    }
  end
end
