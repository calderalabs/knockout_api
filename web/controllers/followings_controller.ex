defmodule KnockoutApi.FollowingsController do
  use Timex
  alias KnockoutApi.{Repo, Following}
  use KnockoutApi.Web, :controller
  import KnockoutApi.BaseController

  def index(conn, _params) do
    render conn, data: Repo.all(Ecto.assoc(current_user(conn), :followings))
    |> Repo.preload([:tournament]), opts: %{ followings: [] }
  end

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data)
    |> Dict.put("user_id", current_user(conn).id)
    |> Dict.put("seen_at", Timex.now)

    changeset = Following.changeset(%Following{}, attrs)

    case Repo.insert(changeset) do
      {:ok, following} ->
        data = following |> KnockoutApi.BasicFollowingsView.format(conn)

        conn
        |> put_status(201)
        |> json data
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{ "id" => id }) do
    following = Repo.get!(Following, id)
    Repo.delete!(following)
    send_resp conn, :no_content, ""
  end
end
