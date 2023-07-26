defmodule BananaBankWeb.UserControllerTest do
  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "Create a user when receive valid params", %{conn: conn} do
      params = %{
        name: "Jeanderson",
        cep: "12345678",
        email: "Jeanderson@bb.com",
        password: "123456789"
      }

      response =
        conn
        |> post(~p"/api/users", params)
        |> json_response(:created)

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
  end
end
