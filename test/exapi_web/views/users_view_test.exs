defmodule ExapiWeb.UsersViewTest do
  use ExapiWeb.ConnCase, async: true

  import Phoenix.View
  import Exapi.Factory

  alias Exapi.User
  alias ExapiWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", %{token: "668698969846", user: user})

    assert %{
             token: "668698969846",
             user: %User{}
           } = response
  end
end
