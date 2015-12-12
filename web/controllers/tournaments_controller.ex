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
    {:ok, client} = Exredis.start_link

    body = case Exredis.Api.get(client, "dota2_the_score_matches") do
      :undefined ->
        {:ok, matches} = KnockoutApi.TheScore.Server.fetch_matches("dota2")
        Exredis.Api.set(client, "dota2_the_score_matches", Poison.encode!(matches))
        matches
      matches -> Poison.decode!(matches)
    end
  end
end
