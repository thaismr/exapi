defmodule ExapiWeb.UsersViewTest do
  use ExapiWeb.ConnCase, async: true

  import Phoenix.View
  import Exapi.Factory

  alias Exapi.User
  alias ExapiWeb.Auth.Guardian
  alias ExapiWeb.UsersView

  test "renders create.json" do
    user = build(:user)
    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    response = render(UsersView, "create.json", %{token: token, user: user})

    expected_response = %{
      token: token,
      user: %User{
        id: user.id
      }
    }

    assert response == expected_response
  end

  test "renders sign_in.json" do
    user = build(:user)
    {:ok, token, _claims} = Guardian.encode_and_sign(user)

    response = render(UsersView, "sign_in.json", %{token: token})

    expected_response = %{
      token: token
    }

    assert response == expected_response
  end
end
