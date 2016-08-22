defmodule KnockoutApi.Router do
  use KnockoutApi.Web, :router
  use Plug.ErrorHandler

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
    get "/admin/users/:id", UsersController, :show
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
    get "/tournaments/:id", AdminTournamentsController, :show
    post "/tournaments", AdminTournamentsController, :create
    patch "/tournaments/:id", AdminTournamentsController, :update
    delete "/tournaments/:id", AdminTournamentsController, :delete
    get "/teams", AdminTeamsController, :index
    post "/teams", AdminTeamsController, :create
    patch "/teams/:id", AdminTeamsController, :update
    delete "/teams/:id", AdminTeamsController, :delete
    post "/match-groups", AdminMatchGroupsController, :create
    patch "/match-groups/:id", AdminMatchGroupsController, :update
    delete "/match-groups/:id", AdminMatchGroupsController, :delete
    post "/matches", AdminMatchesController, :create
    patch "/matches/:id", AdminMatchesController, :update
    delete "/matches/:id", AdminMatchesController, :delete
  end

  defp authenticate_admin(conn, _opts) do
    if Map.get(KnockoutApi.BaseController.current_user(conn), :admin) do
      conn
    else
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(404, Poison.encode!(%{error: "not found"}))
      |> halt
    end
  end

  defp handle_errors(conn, %{kind: kind, reason: reason, stack: stacktrace}) do
    Rollbax.report(kind, reason, stacktrace, %{params: conn.params})
  end
end
