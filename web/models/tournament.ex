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

  @required_fields ~w(name)
  @optional_fields ~w()

  def fetch_tournaments_from_gosugamers do
    GosugamersParser.Server.get_tournaments
    |> Enum.map(&create/1)
  end

  def create(tournament_params) do
    {:ok, game} = Game.find_or_create_by_name(tournament_params.game)
    Repo.insert(Tournament.changeset(%Tournament{}, %{ name: tournament_params.name, game_id: game.id }))
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> assoc_constraint(:game)
    |> unique_constraint(:name)
  end
end
