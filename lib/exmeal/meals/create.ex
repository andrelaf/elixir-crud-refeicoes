defmodule Exmeal.Meals.Create do
  @moduledoc """
  Inserts a meal into the database.
  """
  alias Exmeal.{Error, Repo}
  alias Exmeal.Meals.Meal

  @type params :: %{
          user_id: Ecto.UUID,
          calories: String.t(),
          date: Calendar.naive_datetime(),
          description: String.t()
        }

  @doc """
  Inserts a meal into the database.
  ## Examples
        iex> params = %{
          user_id: "e79b23ae-5813-4ec3-9976-99493905f5e8",
          calories: "100 kcal",
          date: "2016-04-16 13:30:15",
          description: "1 Ovo"
        }
        iex> Exmeal.Meals.Create.call(params)
        {:ok, %Meal{}}
        iex> Exmeal.Meals.Create.call(%{})
        %Exmeal.Error{result: %Ecto.Changeset{}, status: :bad_request}
  """
  @spec call(params()) ::
          {:ok, Meal.t()}
          | {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
  def call(params) do
    params
    |> Meal.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %Meal{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}) do
    {:error, Error.build(changeset, :bad_request)}
  end
end
