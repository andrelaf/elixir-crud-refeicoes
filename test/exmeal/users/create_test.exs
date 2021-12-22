defmodule Exmeal.Users.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Users.{Create, User}
  alias Exmeal.Error

  describe "call/1" do
    test "When all params are valid, inserts a user into the database." do
      params = build(:user_params)

      response = Create.call(params)

      assert {:ok,
              %User{
                cpf: "001.324.030-23",
                email: "andre@email.com",
                id: _id,
                inserted_at: _inserted_at,
                name: "André Lara Amorim",
                updated_at: _updated_at
              }} = response
    end

    test "When any parameter is blank, returns an error" do
      params = %{
        cpf: "",
        email: "",
        name: ""
      }

      response = Create.call(params)

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :insert,
                   changes: %{},
                   errors: [
                     name: {"can't be blank", [validation: :required]},
                     cpf: {"can't be blank", [validation: :required]},
                     email: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = response
    end

    test "When the email parameter is invalid, returns an error" do
      params = build(:user_params, email: "maiquitome.com")

      response = Create.call(params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :insert,
                  changes: %{
                    cpf: "001.324.030-23",
                    email: "emailinvalido.com",
                    name: "André Lara Amorim"
                  },
                  errors: [email: {"has invalid format", [validation: :format]}],
                  valid?: false
                },
                status: :bad_request
              }} = response
    end
  end
end
