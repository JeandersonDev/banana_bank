defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  alias BananaBank.Users.Delete
  alias BananaBank.Users.Get
  alias BananaBank.Users.Update
  alias BananaBank.Users.Verify

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate get_by_email(email), to: Get, as: :get_by_email
  defdelegate login(params), to: Verify, as: :call
  defdelegate update(params), to: Update, as: :call
end
