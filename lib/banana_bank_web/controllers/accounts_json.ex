defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Account created successfully",
      data: data(account)
    }
  end

  def delete(%{account: account}),
    do: %{message: "Account delete successfully", data: data(account)}

  def get(%{account: account}), do: %{data: data(account)}

  defp data(%Account{id: id, balance: balance, user_id: user_id}) do
    %{
      id: id,
      balance: balance,
      user_id: user_id
    }
  end
end
