defmodule KnockoutApi.Tournament do
  alias KnockoutApi.Tournament
  alias KnockoutApi.Repo

  use KnockoutApi.Web, :model

  schema "tournaments" do
    field :name, :string
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime
    belongs_to :game, KnockoutApi.Game
    has_many :match_groups, KnockoutApi.MatchGroup
    has_many :teams, KnockoutApi.Team

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w(start_at end_at)

  def create(tournament) do
    Repo.insert(Tournament.changeset(%Tournament{}, %{
      name: tournament.name, game_id: tournament.game_id
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
