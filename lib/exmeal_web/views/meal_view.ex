defmodule ExmealWeb.MealView do
  use ExmealWeb, :view

  alias Exmeal.Meals.Meal

  def render("create.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Meal successfully created!",
      meal: meal
    }
  end

  def render("update.json", %{meal: %Meal{} = meal}) do
    %{
      message: "Meal successfully updated!",
      meal: meal
    }
  end

  def render("meal.json", %{meal: %Meal{} = meal}) do
    %{
      meal: meal
    }
  end
end
