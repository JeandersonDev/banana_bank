defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback call(Strin.t()) :: {:ok, map()} | {:error, :atom}
end
