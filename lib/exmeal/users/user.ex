defmodule Exmeal.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder,
           only: [
             :id,
             :cpf,
             :email,
             :name
           ]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field(:cpf, :string)
    field(:email, :string)
    field(:name, :string)

    has_many(:meals, Exmeal.Meals.Meal)

    timestamps()
  end

  @doc false
  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, [:name, :cpf, :email])
    |> validate_required([:name, :cpf, :email])
    |> validate_format(:email, ~r/@/)
  end
end
