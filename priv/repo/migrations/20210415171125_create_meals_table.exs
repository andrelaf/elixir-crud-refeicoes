defmodule Exmeal.Repo.Migrations.CreateMealsTable do
  use Ecto.Migration

  def change do
    create table(:meals, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:description, :string)
      add(:date, :naive_datetime)
      add(:calories, :string)

      timestamps()
    end
  end
end
