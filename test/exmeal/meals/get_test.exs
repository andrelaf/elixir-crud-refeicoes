defmodule Exmeal.Meals.GetTest do
  use Exmeal.DataCase, async: true

  import Exmeal.Factory

  alias Exmeal.Error
  alias Exmeal.Meals.{Get, Meal}
  alias Exmeal.Users.User

  describe "get/1" do
    test "when there is a meal with the given id, returns the meal from the database." do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      response = Get.by_id(id)

      assert {:ok,
              %Meal{
                calories: "100 kcal",
                date: ~N[2016-04-16 13:30:15],
                description: "1 Banana",
                id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
                inserted_at: _inserted_at,
                updated_at: _updated_at
              }} = response
    end

    test "when there is no a meal with the given id, returns an error." do
      response = Get.by_id("1e459e18-5847-4832-8aeb-4c29a869b7be")

      assert {:error, %Error{result: "Meal not found!", status: :not_found}} = response
    end
  end
end
