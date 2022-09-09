defmodule Exapi.Users.GetTest do
  use Exapi.DataCase, async: true

  import Exapi.Factory

  alias Exapi.User
  alias Exapi.Users.Get

  describe "by_id/1" do
    test "when all params are valid, returns the user" do
      %User{id: id} = insert(:user)

      response = Get.by_id(id)

      assert {:ok, %User{id: _id}} = response
    end
  end
end
