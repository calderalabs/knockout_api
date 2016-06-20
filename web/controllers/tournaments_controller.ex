defmodule KnockoutApi.TournamentsController do
  alias KnockoutApi.{Repo, Tournament, Following}
  use KnockoutApi.Web, :controller
  import Ecto.Query
  import KnockoutApi.BaseController

  def index(conn, _params) do
    render conn, data: Repo.all(from t in Tournament) |> Tournament.preload_all, opts: %{
      followings: followings(conn)
    }
  end

  def show(conn, %{ "id" => id }) do
    render conn, data: Repo.get!(Tournament, id) |> Tournament.preload_all, opts: %{
      followings: followings(conn)
    }
  end

  defp followings(conn) do
    case current_user(conn) do
      nil -> []
      user ->
        Repo.all(from f in Following,
          where: f.user_id == ^(user.id)
        )
    end
  end
end
