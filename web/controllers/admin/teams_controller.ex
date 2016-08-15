defmodule KnockoutApi.AdminTeamsController do
  alias KnockoutApi.{Repo, Team}
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    tournaments = Repo.all(from t in Team)
    conn |> json(KnockoutApi.AdminTeamsView.format(tournaments, conn))
  end

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Team.changeset(%Team{}, attrs)

    case Repo.insert(changeset) do
      {:ok, tournament} ->
        data = tournament |> KnockoutApi.AdminTeamsView.format(conn)

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
    team = Repo.get!(Team, id)
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Team.changeset(team, attrs)

    case Repo.update(changeset) do
      {:ok, tournament} ->
        data = tournament |> KnockoutApi.AdminTeamsView.format(conn)

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
