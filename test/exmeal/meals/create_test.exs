defmodule Exmeal.Meals.CreateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Meals.{Create, Meal}
  alias Exmeal.Error

  describe "call/1" do
    test "when all params are valid, inserts a meal into the database." do
      insert(:user)

      params = build(:meal_params)

      response = Create.call(params)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Banana",
                id: _id,
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when some param is invalid, returns an error" do
      params = %{
        calories: "",
        date: "",
        description: "",
        user_id: ""
      }

      response = Create.call(params)

      assert {:error,
              %Error{
                result: %Ecto.Changeset{
                  action: :insert,
                  changes: %{},
                  errors: [
                    description: {"can't be blank", [validation: :required]},
                    date: {"can't be blank", [validation: :required]},
                    calories: {"can't be blank", [validation: :required]},
                    user_id: {"can't be blank", [validation: :required]}
                  ]
                },
                status: :bad_request
              }} = response
    end
  end
end
