defmodule KnockoutApi.FollowingsController do
  alias KnockoutApi.{Repo, Following}
  use KnockoutApi.Web, :controller
  import Ecto.Query
  import KnockoutApi.BaseController

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data) |> Dict.put("user_id", current_user.id)
    changeset = Following.changeset(%Following{}, attrs)

    case Repo.insert(changeset) do
      {:ok, following} ->
        conn
        |> put_status(201)
        |> render(:show, data: following)
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
