defmodule Exmeal.Meals.Meal do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :id,
             :calories,
             :date,
             :description,
             :user_id
           ]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "meals" do
    field(:calories, :string)
    field(:date, :naive_datetime)
    field(:description, :string)

    belongs_to(:user, Exmeal.Users.User)

    timestamps()
  end

  @doc false
  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(meal, attrs) do
    meal
    |> cast(attrs, [:description, :date, :calories, :user_id])
    |> validate_required([:description, :date, :calories, :user_id])
  end
end
