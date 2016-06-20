defmodule KnockoutApi.Router do
  use KnockoutApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
  end

  pipeline :authenticated do
    plug Mellon, validator: {KnockoutApi.Validation, :validate, []}, header: "authorization"
  end

  pipeline :optional_authentication do
    plug Mellon, validator: {KnockoutApi.Validation, :validate, []}, header: "authorization", block: false
  end

  scope "/", KnockoutApi do
    pipe_through :api
    pipe_through :optional_authentication

    get "/tournaments", TournamentsController, :index
    get "/tournaments/:id", TournamentsController, :show
  end

  scope "/", KnockoutApi do
    pipe_through :api
    pipe_through :authenticated

    get "/users/:id", UsersController, :show
    post "/followings", FollowingsController, :create
    delete "/followings/:id", FollowingsController, :delete
    post "/spoilers/", SpoilersController, :create
    post "/watchings", WatchingsController, :create
    delete "/watchings", WatchingsController, :delete
    post "/likes", LikesController, :create
    delete "/likes/:id", LikesController, :delete
  end
end
