defmodule Exmeal.Users.Delete do
  @moduledoc """
  Delete a user from the database.
  """
  alias Exmeal.{Error, Repo}
  alias Exmeal.Users.User

  @doc """
  Delete a user from the database.
  ## Examples
      iex> Exmeal.Users.Delete.call("29dbc706-06fe-42d8-860a-390ffb7652a4")
      {:ok, %Exmeal.Users.User{}}
      iex> Exmeal.Users.Delete.call("29dbc706-06fe-42d8-860a-390ffb7652a4")
      {:error, %Exmeal.Error{result: "User not found!", status: :not_found}}
  """
  @spec call(Ecto.UUID) ::
          {:error,
           %Error{
             result: String.t() | Ecto.Changeset.t(),
             status: :not_found | :bad_request
           }}
          | {:ok, User.t()}
  def call(id) do
    with {:ok, %User{} = user} <- Exmeal.get_user_by_id(id) do
      case Repo.delete(user) do
        {:ok, _schema} = user -> user
        {:error, changeset} -> {:error, Error.build(changeset, :bad_request)}
      end
    end
  end
end
