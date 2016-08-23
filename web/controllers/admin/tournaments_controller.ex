defmodule KnockoutApi.AdminTournamentsController do
  alias KnockoutApi.{Repo, Tournament}
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    tournaments = Repo.all(from t in Tournament)
    conn |> json(KnockoutApi.AdminBasicTournamentsView.format(tournaments, conn))
  end

  def show(conn, %{ "id" => id }) do
    tournament = Repo.get!(Tournament, id) |> Repo.preload([match_groups: [:team_one, :team_two, matches: [:winner]]])
    conn |> json(KnockoutApi.AdminTournamentsView.format(tournament, conn))
  end

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Tournament.changeset(%Tournament{}, attrs)

    case Repo.insert(changeset) do
      {:ok, tournament} ->
        data = tournament |> Repo.preload([match_groups: [:team_one, :team_two, matches: [:winner]]]) |> KnockoutApi.AdminBasicTournamentsView.format(conn)

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
    team = Repo.get!(Tournament, id)
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Tournament.changeset(team, attrs)

    case Repo.update(changeset) do
      {:ok, tournament} ->
        data = tournament |> Repo.preload([match_groups: [:team_one, :team_two, matches: [:winner]]]) |> KnockoutApi.AdminBasicTournamentsView.format(conn)

        conn
        |> put_status(200)
        |> json(data)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end

  def delete(conn, %{ "id" => id }) do
    tournament = Repo.get!(Tournament, id)
    Repo.delete!(tournament)
    send_resp conn, :no_content, ""
  end
end
