defmodule KnockoutApi.Router do
  use KnockoutApi.Web, :router

  pipeline :api do
    plug :accepts, ["json-api"]
    plug JaSerializer.Deserializer
  end

  pipeline :authenticated do
    plug Mellon, validator: {KnockoutApi.Validation, :validate, []}, header: "authorization"
  end

  pipeline :optional_authentication do
    plug Mellon, validator: {KnockoutApi.Validation, :validate, []}, header: "authorization", block: false
  end

  pipeline :admin_authentication do
    plug :authenticate_admin
  end

  scope "/", KnockoutApi do
    pipe_through :api
    pipe_through :optional_authentication

    get "/tournaments", TournamentsController, :index
    get "/tournaments/:id", TournamentsController, :show
    get "/match_groups", MatchGroupsController, :index
  end

  scope "/", KnockoutApi do
    pipe_through :api
    pipe_through :authenticated

    get "/users/:id", UsersController, :show
    get "/followings", FollowingsController, :index
    post "/followings", FollowingsController, :create
    delete "/followings/:id", FollowingsController, :delete
    post "/spoilers", SpoilersController, :create
    post "/watchings", WatchingsController, :create
    delete "/watchings/:id", WatchingsController, :delete
    post "/likes", LikesController, :create
    delete "/likes/:id", LikesController, :delete
  end

  scope "/admin", KnockoutApi do
    pipe_through :api
    pipe_through :authenticated
    pipe_through :admin_authentication

    get "/tournaments", AdminTournamentsController, :index
    post "/tournaments", AdminTournamentsController, :create
  end

  defp authenticate_admin(conn, _opts) do
    if conn.assigns.current_user.admin do
      conn
    else
      halt(conn)
    end
  end
end
