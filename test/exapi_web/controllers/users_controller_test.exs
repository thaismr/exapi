defmodule ExapiWeb.UsersControllerTest do
  use ExapiWeb.ConnCase, async: true

  import Exapi.Factory

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "user" => _user,
               "token" => _token
             } = response
    end

    test "when there are errors, returns the error", %{conn: conn} do
      params = %{"password" => "123"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "password" => ["should be at least 6 character(s)"]
        }
      }

      assert response == expected_response
    end
  end

  describe "sign_in/2" do
    setup %{conn: conn} do
      insert(:user)

      {:ok, conn: conn}
    end

    test "when all params are valid, returns a token", %{conn: conn} do
      params = build(:login_params)

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:ok)

      assert %{"token" => _token} = response
    end

    test "when password is invalid, returns an error", %{conn: conn} do
      params = build(:login_params, %{"password" => "123"})

      response =
        conn
        |> post(Routes.users_path(conn, :sign_in, params))
        |> json_response(:unauthorized)

      expected_response = %{"message" => "Please verify your credentials"}

      assert response == expected_response
    end
  end
end
