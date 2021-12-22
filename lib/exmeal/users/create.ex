defmodule Exmeal.Users.Create do
  alias Exmeal.Users.User
  alias Exmeal.{Error, Repo}

  @typedoc """
  User params.
  """
  @type user_params :: %{
          cpf: String.t(),
          email: String.t(),
          name: String.t()
        }

  @doc """
  Inserts a user into the database.
  ## Examples
      iex> params = %{
        cpf: "001.324.030-23",
        email: "andre@email.com",
        name: "André Lara Amorim"
      }
      iex> Exmeal.Users.Create.call(params)
      {:ok, %Exmeal.Users.User{}}
      iex> Exmeal.Users.Create.call(%{})
      {:error, %Exmeal.Error{result: %Ecto.Changeset{}, status: :bad_request}}
  """
  @spec call(user_params()) ::
          {:error, %Error{result: Ecto.Changeset.t(), status: :bad_request}}
          | {:ok, User.t()}
  def call(%{} = params) do
    params
    |> User.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}) do
    {:error, Error.build(changeset, :bad_request)}
  end
end
