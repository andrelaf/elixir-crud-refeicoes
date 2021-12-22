defmodule Exmeal.Users.DeleteTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Error
  alias Exmeal.Users.{Delete, User}

  describe "call/1" do
    test "When there is a user with the given ID, deletes the user." do
      %User{id: id} = insert(:user)

      response = Delete.call(id)

      assert {:ok,
              %User{
                cpf: "001.324.030-23",
                email: "andre@email.com",
                id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
                inserted_at: _inserted_at,
                name: "André Lara Amorim",
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a user with the given ID, returns an error." do
      response = Delete.call("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "User not found!", status: :not_found}} = response
    end
  end
end
