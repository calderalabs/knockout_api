defmodule KnockoutApi.TournamentsController do
  alias Knockout.Repo
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    render conn, model: KnockoutApi.Tournament |> Repo.all |> Repo.preload(:game)
  end
end
