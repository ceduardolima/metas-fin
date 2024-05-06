defmodule MetasFinWeb.Router do
  use MetasFinWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MetasFinWeb do
    pipe_through :api
  end
end
