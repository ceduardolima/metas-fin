defmodule MetasFinWeb.Router do
  use MetasFinWeb, :router

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
