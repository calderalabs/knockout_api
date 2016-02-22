defmodule KnockoutApi.TournamentsController do
  alias Knockout.Repo
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    json conn, fetch_matches
  end

  def show(conn, _params) do
    json conn, fetch_matches
  end

  defp fetch_matches do
    KnockoutApi.TheScore.Server.fetch_matches("dota2")
  end
end
