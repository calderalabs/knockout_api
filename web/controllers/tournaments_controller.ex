defmodule KnockoutApi.TournamentsController do
  alias KnockoutApi.Repo
  alias KnockoutApi.Tournament
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    render conn, data: Repo.all(Tournament)
  end

  def show(conn, %{ "id" => id }) do
    render conn, data: Repo.get(Tournament, id)
  end
end
