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
    %{ data: Repo.all(KnockoutApi.Tournament) }
  end
end
