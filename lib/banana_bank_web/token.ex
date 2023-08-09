defmodule BananaBankWeb.Token do
  alias BananaBankWeb.Endpoint
  alias Phoenix.Token

  @salt "banana_bank_api"

  def sign(%{email: email} = _user) do
    Token.sign(Endpoint, @salt, %{email: email})
  end

  def verify(token), do: Token.verify(Endpoint, @salt, token)
end
