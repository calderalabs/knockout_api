defmodule KnockoutApi.AdminMatchesController do
  alias KnockoutApi.{Repo, Match}
  use KnockoutApi.Web, :controller

  def update(conn, %{ "id" => id, "data" => data }) do
    match = Repo.get!(Match, id)
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Match.changeset(match, attrs)

    case Repo.update(changeset) do
      {:ok, match} ->
        data = match |> Repo.preload([:winner]) |> KnockoutApi.AdminMatchesView.format(conn)

        conn
        |> put_status(200)
        |> json(data)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end
end
