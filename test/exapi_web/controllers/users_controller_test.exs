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
end
