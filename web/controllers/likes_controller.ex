defmodule KnockoutApi.LikesController do
  alias KnockoutApi.{Repo, Like}
  use KnockoutApi.Web, :controller
  import KnockoutApi.BaseController

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data) |> Dict.put("user_id", current_user.id)
    changeset = Like.changeset(%Like{}, attrs)

    case Repo.insert(changeset) do
      {:ok, like} ->
        conn
        |> put_status(201)
        |> render(:show, data: like)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{ "id" => id }) do
    like = Repo.get!(Like, id)
    Repo.delete!(like)
    send_resp conn, :no_content, ""
  end
end
