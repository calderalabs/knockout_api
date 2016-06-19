defmodule KnockoutApi.TournamentsController do
  alias KnockoutApi.{Repo, Tournament, Following}
  use KnockoutApi.Web, :controller
  import Ecto.Query
  import KnockoutApi.BaseController

  def index(conn, _params) do
    render conn, data: Repo.all(Tournament), opts: %{
      followings: followings
    }
  end

  def show(conn, %{ "id" => id }) do
    render conn, data: Repo.get!(Tournament, id), opts: %{
      followings: followings
    }
  end

  defp followings do
    Repo.all(from f in Following,
      where: f.user_id == ^(current_user.id)
    )
  end
end
