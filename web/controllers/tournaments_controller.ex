defmodule KnockoutApi.TournamentsController do
  alias KnockoutApi.{Repo, Tournament, Following}
  use KnockoutApi.Web, :controller
  import Ecto.Query
  import KnockoutApi.BaseController

  def index(conn, _params) do
    render conn, data: Repo.all(from t in Tournament) |> Tournament.preload_all, opts: %{
      current_user: current_user(conn)
    }
  end

  def show(conn, %{ "id" => id }) do
    render conn, data: Repo.get!(Tournament, id) |> Tournament.preload_all, opts: %{
      current_user: current_user(conn)
    }
  end
end
