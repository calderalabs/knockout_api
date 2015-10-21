defmodule KnockoutApi.TournamentsController do
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    render conn, model: KnockoutApi.Repo.all(KnockoutApi.Tournament)
  end
end
