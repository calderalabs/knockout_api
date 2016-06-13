defmodule KnockoutApi.TournamentsController do
  alias KnockoutApi.{Repo, Tournament, User, Following}
  use KnockoutApi.Web, :controller
  import Ecto.Query

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

  defp current_user do
    Repo.all(from u in User, limit: 1) |> List.first
  end

  defp followings do
    Repo.all(from f in Following,
      where: f.user_id == ^(current_user.id)
    )
  end
end
