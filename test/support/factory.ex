defmodule BananaBank.Factory do
  use ExMachina.Ecto, repo: BananaBank.Repo

  # User
  use BananaBank.Factories.UserFactory
end
