defmodule KnockoutApi.TournamentsController do
  alias Knockout.Repo
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    {:ok, body} = KnockoutApi.TheScore.Server.fetch_matches("dota2")
    json conn, body
  end
end
