defmodule KnockoutApi.TournamentsController do
  alias KnockoutApi.{Repo, Tournament, User}
  use KnockoutApi.Web, :controller
  import Ecto.Query
  import KnockoutApi.BaseController

  def index(conn, _params) do
    tournaments = Repo.all(from t in Tournament, where: t.draft == false)
    followings = User.filter_query_by_user(Ecto.assoc(tournaments, :followings), current_user(conn))

    render conn, data: tournaments, opts: %{ followings: followings }
  end

  def show(conn, %{ "id" => id }) do
    tournament = Repo.get!(Tournament, id)
    followings = User.filter_query_by_user(Ecto.assoc(tournament, :followings), current_user(conn))

    render conn, data: tournament, opts: %{ followings: followings }
  end
end
