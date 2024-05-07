defmodule MetasFinWeb.Errors.ErrorHandler.Unauthorized do
  defexception message: "Não autorizado", plug_status: 401
end

defmodule MetasFinWeb.Errors.ErrorHandler.Forbidden do
  defexception message: "Accesso negado", plug_status: 403
end
