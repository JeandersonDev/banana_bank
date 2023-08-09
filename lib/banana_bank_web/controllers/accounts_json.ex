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

  def transaction(%{transaction: %{withdraw: from_account, deposit: to_account} = _transaction}) do
    %{
      message: "Successful Transaction",
      from_account: data(from_account),
      to_account: data(to_account)
    }
  end

  defp data(%Account{id: id, balance: balance, user_id: user_id}) do
    %{
      id: id,
      balance: balance,
      user_id: user_id
    }
  end
end
