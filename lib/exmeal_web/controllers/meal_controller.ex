defmodule ExmealWeb.MealController do
  use ExmealWeb, :controller

  alias Exmeal.Meals.Meal

  action_fallback(ExmealWeb.FallbackController)

  def create(conn, params) do
    with {:ok, %Meal{} = meal} <- Exmeal.create_meal(params) do
      conn
      |> put_status(:created)
      |> render("create.json", meal: meal)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Meal{} = meal} <- Exmeal.get_meal_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("meal.json", meal: meal)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Meal{}} <- Exmeal.delete_meal(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %Meal{} = meal} <- Exmeal.update_meal(id, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", meal: meal)
    end
  end
end
