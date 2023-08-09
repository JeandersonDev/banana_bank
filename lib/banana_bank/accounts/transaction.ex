defmodule BananaBank.Accounts.Transaction do
  alias Ecto.Multi
  alias BananaBank.Accounts
  alias BananaBank.Repo
  alias Accounts.Account

  def call(%{
        "from_account_id" => from_account_id,
        "to_account_id" => to_account_id,
        "value" => value
      }) do
    with {:ok, from_account, to_account, value} <-
           check_transaction(from_account_id, to_account_id, value) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transaction()
      |> handle_transaction()
    else
      {:error, msg} -> {:error, msg}
    end
  end

  def call(_), do: {:error, "Invalid Params"}

  defp check_transaction(from_account_id, to_account_id, value) do
    with {:ok, from_account, to_account} <- check_accounts(from_account_id, to_account_id) do
      case check_value(from_account, value) do
        {:ok, value} -> {:ok, from_account, to_account, value}
        {:error, msg} -> {:error, msg}
      end
    else
      {:error, msg} -> {:error, msg}
    end
  end

  defp check_accounts(from_account_id, to_account_id) do
    from_account = Repo.get(Account, from_account_id)
    to_account = Repo.get(Account, to_account_id)

    case {from_account, to_account} do
      {%Account{}, %Account{}} ->
        {:ok, from_account, to_account}

      {nil, %Account{}} ->
        {:error, "From account is invalid"}

      {%Account{}, nil} ->
        {:error, "To account is invalid"}

      {nil, nil} ->
        {:error, "Accounts is invalid"}
    end
  end

  defp check_value(%{balance: balance} = _from_account, value) do
    with {:ok, value} <- Decimal.cast(value) do
      case balance do
        b when b >= value -> {:ok, value}
        _ -> {:error, "Insufficient account balance"}
      end
    else
      :error -> {:error, "Invalid value"}
    end
  end

  defp withdraw(multi, %{balance: balance} = from_account, value) do
    new_balance = Decimal.sub(balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, %{balance: balance} = to_account, value) do
    new_balance = Decimal.add(balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end

  defp handle_transaction({:ok, _result} = result), do: result
  defp handle_transaction({:error, _op, reason, _}), do: {:error, reason}
end
