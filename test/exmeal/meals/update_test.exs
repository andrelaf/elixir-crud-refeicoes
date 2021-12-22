defmodule Exmeal.Meals.UpdateTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Error
  alias Exmeal.Meals.{Update, Meal}
  alias Exmeal.Users.User

  describe "call/2" do
    test "When all params are valid and there is a meal with the given ID, updates the meal" do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      params =
        build(:meal_params,
          calories: "200 kcal",
          date: "2016-05-10 12:20:10",
          description: "2 Bananas"
        )

      response = Update.call(id, params)

      assert {:ok,
              %Meal{
                calories: "200 kcal",
                date: ~N[2016-05-10 12:20:10],
                description: "2 Bananas",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "When there is no a meal with the given ID, returns an error" do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      params = %{
        calories: "200 kcal",
        date: "2016-05-10 12:20:10",
        description: "2 Bananas"
      }

      response = Update.call(id, params)

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end

    test "When some param is invalid, returns an error" do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      params = %{
        calories: "",
        date: "",
        description: ""
      }

      response = Update.call(id, params)

      assert {
               :error,
               %Error{
                 result: %Ecto.Changeset{
                   action: :update,
                   changes: %{},
                   errors: [
                     description: {"can't be blank", [validation: :required]},
                     date: {"can't be blank", [validation: :required]},
                     calories: {"can't be blank", [validation: :required]}
                   ],
                   valid?: false
                 },
                 status: :bad_request
               }
             } = response
    end
  end
end
