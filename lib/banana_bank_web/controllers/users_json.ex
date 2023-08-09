defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  def delete(%{user: user}), do: %{message: "User delete successfully", data: data(user)}
  def get(%{user: user}), do: %{data: data(user)}

  def login(%{login: token}) do
    %{
      message: "User authenticated successfully",
      bearer: token
    }
  end

  def update(%{user: user}), do: %{message: "User update successfully", data: data(user)}

  defp data(%User{id: id, name: name, email: email, cep: cep}) do
    %{
      id: id,
      name: name,
      email: email,
      cep: cep
    }
  end
end
