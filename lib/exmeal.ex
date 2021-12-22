defmodule Exmeal do
  alias Exmeal.Meals.Create, as: CreateMeal
  alias Exmeal.Meals.Delete, as: DeleteMeal
  alias Exmeal.Meals.Get, as: GetMeal
  alias Exmeal.Meals.Update, as: UpdateMeal

  defdelegate create_meal(params), to: CreateMeal, as: :call
  defdelegate delete_meal(params), to: DeleteMeal, as: :call
  defdelegate get_meal_by_id(params), to: GetMeal, as: :by_id
  defdelegate update_meal(id, params), to: UpdateMeal, as: :call

  alias Exmeal.Users.Create, as: CreateUser
  alias Exmeal.Users.Get, as: GetUser
  alias Exmeal.Users.Delete, as: DeleteUser
  alias Exmeal.Users.Update, as: UpdateUser

  defdelegate create_user(params), to: CreateUser, as: :call
  defdelegate get_user_by_id(id), to: GetUser, as: :by_id
  defdelegate delete_user(id), to: DeleteUser, as: :call
  defdelegate update_user(id, params), to: UpdateUser, as: :call
end
