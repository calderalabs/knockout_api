defmodule KnockoutApi.AdminMatchGroupsController do
  alias KnockoutApi.{Repo, MatchGroup}
  use KnockoutApi.Web, :controller

  def update(conn, %{ "id" => id, "data" => data }) do
    match_group = Repo.get!(MatchGroup, id) |> Repo.preload([:team_one, :team_two, matches: [:winner]])
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = MatchGroup.changeset(match_group, attrs)
    IO.inspect(changeset)

    case Repo.update(changeset) do
      {:ok, match_group} ->
        data = match_group |> KnockoutApi.AdminMatchGroupsView.format(conn)

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
