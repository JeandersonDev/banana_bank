defmodule BananaBank.ViaCep.ClientTest do
  alias BananaBank.ViaCep.Client
  use ExUnit.Case, async: true

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "Succesfully returns cep info", %{bypass: bypass} do
      cep = "44007200"

      body = ~s({
        "bairro": "Pedra do Descanso",
        "cep": "44007-200",
        "complemento": "",
        "ddd": "75",
        "gia": "",
        "ibge": "2910800",
        "localidade": "Feira de Santana",
        "logradouro": "Avenida Rubens Carvalho",
        "siafi": "3515",
        "uf": "BA"
      })

      expected_response =
        {:ok,
         %{
           "bairro" => "Pedra do Descanso",
           "cep" => "44007-200",
           "complemento" => "",
           "ddd" => "75",
           "gia" => "",
           "ibge" => "2910800",
           "localidade" => "Feira de Santana",
           "logradouro" => "Avenida Rubens Carvalho",
           "siafi" => "3515",
           "uf" => "BA"
         }}

      Bypass.expect(bypass, "GET", "/44007200/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call(cep)

      assert response == expected_response
    end
  end

  defp endpoint_url(port), do: "http://localhost:#{port}"
end
