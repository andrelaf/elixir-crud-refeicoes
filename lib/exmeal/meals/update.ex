defmodule Exmeal.Meals.Update do
  @moduledoc """
  Updates a meal in the database.
  """
  alias Exmeal.Meals.Meal
  alias Exmeal.{Error, Repo}

  @typedoc """
  Meal params.
  """
  @type params :: %{
          calories: String.t(),
          date: Calendar.naive_datetime(),
          description: String.t()
        }

  @doc """
  Updates a meal in the database.
  ## Examples
      iex> meal_id = "8aa2e580-7726-49ee-8f83-3c86d79d4a08"
      iex> params = %{calories: "200 kcal", date: "2016-05-16 13:30:15", description: "2 Ovos"}
      iex> Exmeal.Meals.Update.call(meal_id, params)
      {:ok, %Exmeal.Meals.Meal{}}
      iex> Exmeal.Meals.Update.call("8aa2e580-7726-49ee-8f83-3c86d79d4a00", params)
      {:error, %Exmeal.Error{result: "Meal not found!", status: :not_found}}
      iex> Exmeal.Meals.Update.call(meal_id, %{calories: "", date: "", description: ""})
      {:error, %Error{result: %Ecto.Changeset{}, status: :bad_request}}
  """
  @spec call(Ecto.UUID, params()) ::
          {:error, %Error{result: String.t(), status: :not_found}}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, Meal.t()}
  def call(meal_id, %{} = params) do
    with {:ok, %Meal{} = meal} <- Exmeal.get_meal_by_id(meal_id) do
      do_update(meal, params)
    end
  end

  defp do_update(%Meal{} = meal, %{} = params) do
    meal
    |> Meal.changeset(params)
    |> Repo.update()
    |> handle_update()
  end

  defp handle_update({:ok, %Meal{}} = result), do: result

  defp handle_update({:error, %Ecto.Changeset{} = changeset}) do
    {:error, Error.build(changeset, :bad_request)}
  end
end
