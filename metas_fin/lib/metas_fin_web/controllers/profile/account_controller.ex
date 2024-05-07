defmodule MetasFinWeb.Profile.AccountController do
  use MetasFinWeb, :controller

  alias MetasFin.Profiles
  alias MetasFin.Profiles.Account

  action_fallback MetasFinWeb.FallbackController

  def index(conn, _params) do
    accounts = Profiles.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Profiles.create_account(account_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/profile/accounts/#{account}")
      |> render(:show, account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Profiles.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Profiles.get_account!(id)

    with {:ok, %Account{} = account} <- Profiles.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Profiles.get_account!(id)

    with {:ok, %Account{}} <- Profiles.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
