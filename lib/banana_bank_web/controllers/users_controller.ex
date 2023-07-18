defmodule BananaBankWeb.UsersController do
  use BananaBankWeb, :controller

  alias BananaBank.Users.Create
  alias BananaBankWeb.ErrorJSON

  def create(conn, params) do
    params
    |> Create.call()
    |> handle_response(conn)
  end

  defp handle_response({:ok, user}, conn) do
    conn
    |> put_status(:created)
    |> render(:create, user: user)
  end

  defp handle_response({:error, changeset}, conn) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
