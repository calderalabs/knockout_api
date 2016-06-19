defmodule KnockoutApi.WatchingsController do
  alias KnockoutApi.{Repo, Watching}
  use KnockoutApi.Web, :controller
  import KnockoutApi.BaseController

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data) |> Dict.put("user_id", current_user.id)
    changeset = Watching.changeset(%Watching{}, attrs)

    case Repo.insert(changeset) do
      {:ok, watching} ->
        conn
        |> put_status(201)
        |> render(:show, data: watching)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{ "id" => id }) do
    watching = Repo.get!(Watching, id)
    Repo.delete!(watching)
    send_resp conn, :no_content, ""
  end
end
