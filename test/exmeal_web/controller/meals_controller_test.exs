defmodule ExmealWeb.MealControllerTest do
  use ExmealWeb.ConnCase, async: true

  import Exmeal.Factory

  alias Exmeal.Meals.Meal
  alias Exmeal.Users.User

  describe "create/2" do
    test "when all params are valid, inserts a meal into the database.", %{conn: conn} do
      %User{} = insert(:user)

      params = build(:meal_params)

      response =
        conn
        |> post(Routes.meal_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "meal" => %{
                 "calories" => "100 kcal",
                 "date" => "2016-04-16T13:30:15",
                 "description" => "1 Banana",
                 "id" => _id
               },
               "message" => "Meal successfully created!"
             } = response
    end

    test "when some param is invalid, returns an error", %{conn: conn} do
      params = %{
        calories: "",
        date: "",
        description: ""
      }

      response =
        conn
        |> post(Routes.meal_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "calories" => ["can't be blank"],
                 "date" => ["can't be blank"],
                 "description" => ["can't be blank"]
               }
             } = response
    end
  end

  describe "show/2" do
    test "when there is a meal with the given id, returns the meal from the database.", %{
      conn: conn
    } do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      response =
        conn
        |> get(Routes.meal_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => "100 kcal",
                 "date" => "2016-04-16T13:30:15",
                 "description" => "1 Banana",
                 "id" => "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8"
               }
             } = response
    end

    test "when there is no a meal with the given id, returns an error.", %{conn: conn} do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      response =
        conn
        |> get(Routes.meal_path(conn, :show, id))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found!"} = response
    end
  end

  describe "delete/2" do
    test "When there is a meal with the given ID, deletes the meal.", %{conn: conn} do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      response =
        conn
        |> delete(Routes.meal_path(conn, :delete, id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end

    test "When there is no a meal with the given ID, returns an error.", %{conn: conn} do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      response =
        conn
        |> delete(Routes.meal_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"message" => "Meal not found!"}

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "When all params are valid and there is a meal with the given ID, updates the meal", %{
      conn: conn
    } do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      params = %{
        "calories" => "200 kcal",
        "date" => "2016-05-10 12:20:10",
        "description" => "2 Bananas"
      }

      response =
        conn
        |> put(Routes.meal_path(conn, :update, id, params))
        |> json_response(:ok)

      assert %{
               "meal" => %{
                 "calories" => "200 kcal",
                 "date" => "2016-05-10T12:20:10",
                 "description" => "2 Bananas",
                 "id" => "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8"
               },
               "message" => "Meal successfully updated!"
             } = response
    end

    test "When there is no a meal with the given ID, returns an error", %{conn: conn} do
      id = "1e459e18-5847-4832-8aeb-4c29a869b7be"

      params = %{
        "calories" => "200 kcal",
        "date" => "2016-05-10 12:20:10",
        "description" => "2 Bananas"
      }

      response =
        conn
        |> put(Routes.meal_path(conn, :update, id, params))
        |> json_response(:not_found)

      assert %{"message" => "Meal not found!"} = response
    end

    test "When some param is invalid, returns an error", %{conn: conn} do
      %User{} = insert(:user)

      %Meal{id: id} = insert(:meal)

      params = %{
        "calories" => "",
        "date" => "",
        "description" => ""
      }

      response =
        conn
        |> put(Routes.meal_path(conn, :update, id, params))
        |> json_response(:bad_request)

      assert %{
               "message" => %{
                 "calories" => ["can't be blank"],
                 "date" => ["can't be blank"],
                 "description" => ["can't be blank"]
               }
             } = response
    end
  end
end
