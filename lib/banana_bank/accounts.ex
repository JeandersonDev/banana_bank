defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Create
  alias BananaBank.Accounts.Delete
  alias BananaBank.Accounts.Get
  alias BananaBank.Accounts.Transaction

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
