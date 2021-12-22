defmodule ExmealWeb.UserView do
  use ExmealWeb, :view

  alias Exmeal.Users.User

  def render("create.json", %{user: %User{} = user}) do
    %{
      message: "User successfully created!",
      user: user
    }
  end

  def render("user.json", %{user: %User{} = user}) do
    %{user: user}
  end

  def render("update.json", %{user: %User{} = user}) do
    %{
      message: "User successfully updated!",
      user: user
    }
  end
end
