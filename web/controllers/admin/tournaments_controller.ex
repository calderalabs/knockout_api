defmodule KnockoutApi.AdminTournamentsController do
  alias KnockoutApi.{Repo, Tournament}
  use KnockoutApi.Web, :controller

  def index(conn, _params) do
    tournaments = Repo.all(from t in Tournament)
    conn |> json(KnockoutApi.AdminTournamentsView.format(tournaments, conn))
  end

  def create(conn, %{ "data" => data }) do
    attrs = JaSerializer.Params.to_attributes(data)
    changeset = Tournament.changeset(%Tournament{}, attrs)

    case Repo.insert(changeset) do
      {:ok, tournament} ->
        data = tournament |> KnockoutApi.AdminTournamentsView.format(conn)

        conn
        |> put_status(201)
        |> json(data)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render(:errors, data: changeset)
    end
  end
end
