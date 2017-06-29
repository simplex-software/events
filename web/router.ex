defmodule Events.Router do
  use Events.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end


  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Events do
    pipe_through :browser # Use the default browser stack
<<<<<<< Updated upstream
    
=======

>>>>>>> Stashed changes
    resources "/users", UserController

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Events do
  #   pipe_through :api
  # end
end
