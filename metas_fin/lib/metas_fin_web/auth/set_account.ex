defmodule MetasFinWeb.Auth.SetAccount do
  import Plug.Conn
  alias MetasFinWeb.Errors.ErrorHandler
  alias MetasFin.Profiles.Accounts

  def init(_optional) do
  end

  def call(conn, _opts) do
    if conn.assigns[:account] do
      conn
    else
      account_id = get_session(conn, :account_id)
      if account_id == nil, do: raise(ErrorHandler.Unauthorized)
      account = Accounts.get_full_account(account_id)

      cond do
        account_id && account -> assign(conn, :account, account)
        true -> assign(conn, :account, nil)
      end
    end
  end
end
