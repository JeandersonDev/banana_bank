defmodule BananaBank.Accounts.Delete do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo

  def call(id) do
    with %Account{balance: balance} = account <- Repo.get(Account, id) do
      case Decimal.compare(balance, 0) do
        :eq -> Repo.delete(account)
        _ -> {:error, :bad_request}
      end
    else
      nil -> {:error, :not_found}
    end
  end
end
