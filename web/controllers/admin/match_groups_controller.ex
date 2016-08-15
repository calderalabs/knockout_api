defmodule KnockoutApi.AdminMatchGroupsController do
  alias KnockoutApi.{Repo, MatchGroup}
  use KnockoutApi.Web, :controller

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = MatchGroup.changeset(%MatchGroup{}, attrs)

    case Repo.insert(changeset) do
      {:ok, match_group} ->
        data = match_group |> KnockoutApi.AdminMatchesView.format(conn)

        conn
        |> put_status(201)
        |> json(data)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end

  def update(conn, %{ "id" => id, "data" => data }) do
    match_group = Repo.get!(MatchGroup, id)
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = MatchGroup.changeset(match_group, attrs)

    case Repo.update(changeset) do
      {:ok, match_group} ->
        data = match_group |> Repo.preload([:team_one, :team_two, matches: [:winner]]) |> KnockoutApi.AdminMatchGroupsView.format(conn)

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
