defmodule MetasFinWeb.Router do
  use MetasFinWeb, :router
  use Plug.ErrorHandler

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{reason: %Phoenix.Router.NoRouteError{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  @impl Plug.ErrorHandler
  def handle_errors(conn, %{reason: %{message: message}}) do
    conn
    |> json(%{errors: message})
    |> halt()
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug MetasFinWeb.Auth.Pipeline
    plug MetasFinWeb.Auth.SetAccount
  end

  scope "/auth", MetasFinWeb do
    pipe_through :api
    post "/register", Profile.AccountController, :create
  end
end
