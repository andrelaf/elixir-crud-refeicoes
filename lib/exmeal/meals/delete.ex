defmodule Exmeal.Meals.Delete do
  @moduledoc """
  Delete a meal from the database.
  """

  alias Exmeal.Meals.Meal
  alias Exmeal.{Error, Repo}

  @doc """
  Delete a meal from the database.
  ## Examples
      iex> Exmeal.Meals.Delete.call("867a7df1-4461-4f87-8f33-f0c299ac56df")
      {:ok, %Exmeal.Meals.Meal{}}
      iex> Exmeal.Meals.Delete.call("867a7df1-4461-4f87-8f33-f0c299ac56da")
      {:error, %Exmeal.Error{result: "Meal not found!", status: :not_found}}
  """
  @spec call(Ecto.UUID) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, Meal.t()}
  def call(meal_id) do
    with {:ok, %Meal{} = meal} <- Exmeal.get_meal_by_id(meal_id) do
      case Repo.delete(meal) do
        {:ok, _struct} = result -> result
        {:error, changeset} -> {:error, Error.build(changeset, :bad_request)}
      end
    end
  end
end
