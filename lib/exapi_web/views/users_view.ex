defmodule ExapiWeb.UsersView do
  use ExapiWeb, :view

  alias Exapi.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      token: token,
      user: user
    }
  end

  def render("sign_in.json", %{token: token}) do
    %{token: token}
  end

  def render("user.json", %{user: %User{} = user}) do
    %{user: user}
  end
end
