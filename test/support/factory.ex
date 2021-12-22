defmodule Exmeal.Factory do
  use ExMachina.Ecto, repo: Exmeal.Repo

  alias Exmeal.Meals.Meal
  alias Exmeal.Users.User

  # MEAL

  def meal_params_factory do
    %{
      calories: "100 kcal",
      date: "2016-04-16 13:30:15",
      description: "1 Banana",
      user_id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d"
    }
  end

  def meal_factory do
    %Meal{
      calories: "100 kcal",
      date: "2016-04-16T13:30:15",
      description: "1 Banana",
      id: "84dc958f-4e96-4b1f-b164-ea0ba4a2a0e8",
      user_id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d"
    }
  end

  # USER

  def user_params_factory do
    %{
      cpf: "001.324.030-23",
      email: "andre@email.com",
      name: "André Lara Amorim"
    }
  end

  def user_factory do
    %User{
      cpf: "001.324.030-23",
      email: "andre@email.com",
      name: "André Lara Amorim",
      id: "a0694167-d1c7-45a7-a1db-7f1e60e1275d"
    }
  end
end
