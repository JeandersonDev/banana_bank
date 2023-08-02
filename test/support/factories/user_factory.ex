defmodule BananaBank.Factories.UserFactory do
  defmacro __using__(_opts) do
    quote do
      alias BananaBank.Users.User

      def user_factory do
        %User{
          name: Faker.Person.PtBr.first_name(),
          cep: "44007200",
          email: sequence(:email, &"Fulano#{&1}@bb.com"),
          password_hash: Argon2.add_hash("12345678").password_hash
        }
      end
    end
  end
end
