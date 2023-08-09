defmodule BananaBank.Users.Get do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(id) do
    case Repo.get(User, id) do
      nil -> {:error, "User not Found"}
      user -> {:ok, user}
    end
  end

  def get_by_email(email) do
    case Repo.get_by(User, email: email) do
      nil -> {:error, "User not Found"}
      user -> {:ok, user}
    end
  end
end
