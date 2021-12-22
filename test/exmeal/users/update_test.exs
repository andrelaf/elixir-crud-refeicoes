defmodule Exmeal.Users.UpdateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Error
  alias Exmeal.Users.{Update, User}

  describe "call/2" do
    test "When all params are valid and there is a user with the given ID, updates the user" do
      %User{id: id} = insert(:user)

      params =
        build(:user_params,
          cpf: "111.222.333-44",
          email: "userupdated@email.com",
          name: "User Updated"
        )

      response = Update.call(id, params)

      assert {:ok,
              %User{
                cpf: "111.222.333-44",
                email: "userupdated@email.com",
                id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d",
                inserted_at: _inserted_at,
                name: "User Updated",
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a user with the given ID, returns an error" do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      params = %{
        cpf: "111.222.333-44",
        email: "userupdated@email.com",
        name: "User Updated"
      }

      response = Update.call(id, params)

      assert {:error, %Error{result: "User not found!", status: :not_found}} = response
    end

    test "When some param is invalid, returns an error" do
      %User{id: id} = insert(:user)

      params = %{
        cpf: "",
        email: "",
        name: ""
      }

      response = Update.call(id, params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :update,
                  changes: %{},
                  errors: [
                    name: {"can't be blank", [validation: :required]},
                    cpf: {"can't be blank", [validation: :required]},
                    email: {"can't be blank", [validation: :required]}
                  ],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
