defmodule KnockoutApi.Tournament do
  alias KnockoutApi.Tournament
  alias KnockoutApi.Repo
  alias KnockoutApi.Game

  use KnockoutApi.Web, :model

  schema "tournaments" do
    field :name, :string
    belongs_to :game, KnockoutApi.Game

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w()

  def fetch_tournaments_from_gosugamers do
    kimono_apis = [
      %{ game: Game.find_or_create_by_name("Hearthstone"), id: "bpr1x8ms" },
      %{ game: Game.find_or_create_by_name("Dota 2"), id: "3icn6gf2" }
    ] |> Enum.each(&fetch_tournaments_from_kimono/1)
  end

  defp fetch_tournaments_from_kimono(api) do
    game_url = "https://www.kimonolabs.com/api/#{api.id}?apikey=#{Application.get_env(:knockout_api, :kimono_api_key)}"
    {:ok, %HTTPoison.Response{status_code: 200, body: body}} = HTTPoison.get(game_url)
    all = fn :get, data, next -> Enum.map(data, next) end

    body
    |> Poison.decode!
    |> get_in(["results", "collection1", all, "tournament_title", "text"])
    |> Enum.map(&(%{ game: api.game, name: &1 }))
    |> Enum.map(&create/1)
  end

  def create(tournament) do
    Repo.insert(Tournament.changeset(%Tournament{}, %{
      name: tournament.name, game_id: tournament.game.id
    }))
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:game_id)
    |> unique_constraint(:name)
  end
end
