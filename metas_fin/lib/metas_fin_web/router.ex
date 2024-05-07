defmodule MetasFinWeb.Router do
  use MetasFinWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/auth", MetasFinWeb do
    pipe_through :api
    post "/register", Profile.AccountController, :create
  end
end
