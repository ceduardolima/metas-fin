defmodule MetasFinWeb.Profile.AccountController do
  use MetasFinWeb, :controller

  alias MetasFin.Profiles.{Accounts, Users, Guardian}
  alias MetasFin.Profiles.Accounts.Account
  alias MetasFinWeb.Errors.ErrorHandler

  action_fallback MetasFinWeb.FallbackController

  def index(conn, _params) do
    accounts = Accounts.list_accounts()
    render(conn, :index, accounts: accounts)
  end

  @doc """
  Endpoint cria uma nova conta. 
  ## Examples
      
      Valid Request: { account: {email: "email@gmail.com", password: "valid_password", name: "nome"}}
      Response 200: {id: account_id, email: "email@gmail.com", token: jwt_token} 

      Invalid Request: { account: {email: invalid_email, password: invalid_password, name: "nome"}}
      Response 404: {errors: [...]}

      
  """
  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Accounts.create_account(account_params),
         {:ok, _user} <- Users.create_user(account, account_params) do
      authorize_account(conn, account.email, account_params["password"])
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        conn 
          |> put_status(:bad_request)
          |> render(:show_error, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)
    render(conn, :show, account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{} = account} <- Accounts.update_account(account, account_params) do
      render(conn, :show, account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Accounts.get_account!(id)

    with {:ok, %Account{}} <- Accounts.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end

  defp authorize_account(conn, email, password) do
    case Guardian.authenticate(email, password) do
      {:ok, account, token} ->
        conn
        |> Plug.Conn.put_session(:account_id, account.id)
        |> put_status(:ok)
        |> render(:show_token, %{account: account, token: token})

      {:error, :unauthorized} ->
        raise ErrorHandler.Unauthorized, message: "Não authorizado"
    end
  end
end
