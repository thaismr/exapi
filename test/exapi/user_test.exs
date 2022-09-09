defmodule Exapi.UserTest do
  use Exapi.DataCase, async: true

  import Exapi.Factory

  alias Ecto.Changeset
  alias Exapi.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{
               changes: %{password_hash: password_hash},
               valid?: true
             } = response

      assert password_hash != nil
    end

    test "when there are errors, returns an invalid changeset" do
      params = %{"password" => "123"}

      response = User.changeset(params)

      expected_response = %{
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
