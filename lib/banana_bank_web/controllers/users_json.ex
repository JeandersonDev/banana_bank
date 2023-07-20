defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  defp data(%User{id: id, name: name, email: email, cep: cep}) do
    %{
      id: id,
      name: name,
      email: email,
      cep: cep
    }
  end
end
