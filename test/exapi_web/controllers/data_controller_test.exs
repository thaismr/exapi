defmodule ExapiWeb.DataControllerTest do
  use ExapiWeb.ConnCase, async: true

  describe "show/2" do
    test "when the user is not authenticated, returns an error", %{conn: conn} do
      username = "12345"

      response =
        conn
        |> get(Routes.data_path(conn, :show, username))
        |> json_response(:unauthorized)

      assert response == %{"message" => "unauthenticated"}
    end
  end
end
