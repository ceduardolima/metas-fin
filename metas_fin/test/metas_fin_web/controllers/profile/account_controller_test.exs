defmodule MetasFinWeb.Profile.AccountControllerTest do
  use MetasFinWeb.ConnCase

  import MetasFin.ProfilesFixtures

  alias MetasFin.Profiles.Account

  @create_attrs %{
    password: "some password",
    email: "some email"
  }
  @update_attrs %{
    password: "some updated password",
    email: "some updated email"
  }
  @invalid_attrs %{password: nil, email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all accounts", %{conn: conn} do
      conn = get(conn, ~p"/api/profile/accounts")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create account" do
    test "renders account when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/profile/accounts", account: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/profile/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some email",
               "password" => "some password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/profile/accounts", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update account" do
    setup [:create_account]

    test "renders account when data is valid", %{conn: conn, account: %Account{id: id} = account} do
      conn = put(conn, ~p"/api/profile/accounts/#{account}", account: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/profile/accounts/#{id}")

      assert %{
               "id" => ^id,
               "email" => "some updated email",
               "password" => "some updated password"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, account: account} do
      conn = put(conn, ~p"/api/profile/accounts/#{account}", account: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete account" do
    setup [:create_account]

    test "deletes chosen account", %{conn: conn, account: account} do
      conn = delete(conn, ~p"/api/profile/accounts/#{account}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/profile/accounts/#{account}")
      end
    end
  end

  defp create_account(_) do
    account = account_fixture()
    %{account: account}
  end
end
