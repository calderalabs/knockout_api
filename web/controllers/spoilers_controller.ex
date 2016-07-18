defmodule KnockoutApi.SpoilersController do
  alias KnockoutApi.{Repo, Spoiler}
  use KnockoutApi.Web, :controller
  import KnockoutApi.BaseController

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data)
    |> Dict.put("user_id", current_user(conn).id)
    |> Dict.to_list
    |> Enum.reduce(%{}, fn {key, value}, acc ->
      Dict.put(acc, String.replace(key, "-", "_"), value)
    end)

    changeset = Spoiler.changeset(%Spoiler{}, attrs)

    case Repo.insert(changeset) do
      {:ok, spoiler} ->
        conn
        |> put_status(201)
        |> render(:show, data: spoiler)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end
end
