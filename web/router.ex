defmodule KnockoutApi.Router do
  use KnockoutApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  scope "/", KnockoutApi do
    pipe_through :api

    get "/tournaments", TournamentsController, :index
    get "/tournaments/:id", TournamentsController, :show
    get "/users/:id", UsersController, :show
    post "/followings", FollowingsController, :create
    delete "/followings/:id", FollowingsController, :delete
  end
end
