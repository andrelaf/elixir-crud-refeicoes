defmodule ExmealWeb.FallbackController do
  use ExmealWeb, :controller

  alias Exmeal.Error
  alias ExmealWeb.ErrorView

  def call(conn, {:error, %Error{result: changeset_or_message, status: status}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: changeset_or_message)
  end
end
