defmodule Artesanos2017Web.Router do
  use Artesanos2017Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Artesanos2017Web do
    pipe_through :api
  end
end
