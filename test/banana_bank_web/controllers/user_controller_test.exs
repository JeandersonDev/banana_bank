defmodule BananaBankWeb.UserControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.ViaCep.ClientMock
  import Mox

  setup :verify_on_exit!

  describe "create/2" do
    test "Create a user when receive valid params", %{conn: conn} do
      params = params_for(:user)
      body = params_for(:cep)

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

      expect(ClientMock, :call, fn "44007200" ->
        {:ok, body}
      end)

      assert %{
               "data" => %{
                 "cep" => "12345678",
                 "email" => "Jeanderson@bb.com",
                 "id" => _id,
                 "name" => "Jeanderson"
               },
               "message" => "User created successfully"
             } = response
    end

    test "Returns an error when receive invalid params", %{conn: conn} do
      params = %{
        name: "Je",
        cep: "123",
        email: nil,
        password: "123"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{
        "errors" => %{
          "cep" => ["should be 8 character(s)"],
          "name" => ["should be at least 3 character(s)"],
          "password" => ["should be at least 6 character(s)"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end

    test "Delete a user when given a valid id", %{conn: conn} do
      user = insert(:user)

      response =
        conn
        |> delete(~p"/api/users/#{user.id}")
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "cep" => user.cep,
          "email" => user.email,
          "id" => user.id,
          "name" => user.name
        },
        "message" => "User delete successfully"
      }

      assert response == expected_response
    end

    test "Returns an error when given a invalid id", %{conn: conn} do
      response =
        conn
        |> delete(~p"/api/users/0")
        |> json_response(:not_found)

      expected_response = %{"error" => "not_found", "message" => "User not found"}

      assert response == expected_response
    end
  end
end
