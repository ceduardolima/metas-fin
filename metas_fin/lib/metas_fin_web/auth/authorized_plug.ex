defmodule MetasFinWeb.Auth.AuthorizedPlug do
  alias MetasFinWeb.Errors.ErrorHandler
  require Logger

  def is_authorized(%{params: %{"account_id" => id}} = conn, _opts) do
    if conn.assigns.account.id == id do
      conn
    else
      raise ErrorHandler.Forbidden
    end
  end

  def is_authorized(%{params: %{"user_id" => id}} = conn, _opts) do
    if conn.assigns.account.id == id do
      conn
    else
      raise ErrorHandler.Forbidden
    end
  end

  def is_authorized(_, _) do
    Logger.error("Chave de identificação não encontrada")
    raise ErrorHandler.Forbidden
  end

end
