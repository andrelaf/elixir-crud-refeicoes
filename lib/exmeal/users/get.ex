defmodule Exmeal.Users.Get do
  @moduledoc """
  Gets a user from the database.
  """

  alias Exmeal.{Error, Repo}
  alias Exmeal.Users.User

  @doc """
  Returns a user from the database.
  ## Examples
      iex> Exmeal.Users.Get.by_id "e79b23ae-5813-4ec3-9976-99493905f5e8"
      {:ok, %Exmeal.Users.User{}}
      iex> Exmeal.Users.Get.by_id "e79b23ae-5813-4ec3-9976-99493905f5e9"
      {:error, %Exmeal.Error{result: "User not found!", status: :not_found}}
  """
  @spec by_id(Ecto.UUID) ::
          {:ok, Usert.t()}
          | {:error, %Error{result: String.t(), status: :not_found}}
  def by_id(id) do
    case Repo.get(User, id) do
      %User{} = user -> {:ok, user}
      nil -> {:error, Error.build_user_not_found_error()}
    end
  end
end
