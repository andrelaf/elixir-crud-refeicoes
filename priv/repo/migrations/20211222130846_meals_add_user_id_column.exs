defmodule Exmeal.Repo.Migrations.MealsAddUserIdColumn do
  use Ecto.Migration

  def change do
    alter table(:meals) do
      add(:user_id, references(:users, type: :binary_id, on_delete: :delete_all))
    end
  end
end
