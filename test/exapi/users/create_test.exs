defmodule Exapi.Users.CreateTest do
  use Exapi.DataCase, async: true

  import Exapi.Factory

  alias Exapi.Error
  alias Exapi.User
  alias Exapi.Users.Create

  describe "call/1" do
    test "when all params are valid, returns the user" do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok, %User{id: _id}} = response
    end

    test "when there are invalid params, returns an error" do
      params = %{"password" => "123"}

      expected_response = %{
        password: ["should be at least 6 character(s)"]
      }

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
