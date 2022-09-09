defmodule ExapiWeb.UsersView do
  use ExapiWeb, :view

  alias Exapi.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      token: token,
      user: user
    }
  end
end
