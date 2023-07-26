defmodule BananaBank.Factories.UserFactory do
  defmacro __using__(_opts) do
    quote do
      alias BananaBank.Users.User

      def user_factory do
        %User{
          name: Faker.Person.PtBr.first_name(),
          cep: "12345678",
          email: sequence(:email, &"Fulano#{&1}@bb.com"),
          password: "12345678"
        }
      end
    end
  end
end
