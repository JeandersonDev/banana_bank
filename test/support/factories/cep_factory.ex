defmodule BananaBank.Factories.CepFactory do
  defmacro __using__(_opts) do
    quote do
      def cep_factory do
        %{
          bairro: "Pedra do Descanso",
          cep: "44007-200",
          complemento: "",
          ddd: "75",
          gia: "",
          ibge: "2910800",
          localidade: "Feira de Santana",
          logradouro: "Avenida Rubens Carvalho",
          siafi: "3515",
          uf: "BA"
        }
      end
    end
  end
end
