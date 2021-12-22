defmodule Exmeal.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add(:id, :binary_id, primary_key: true)
      add(:name, :string)
      add(:cpf, :string)
      add(:email, :string)

      timestamps()
    end
  end
end
