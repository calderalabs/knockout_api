defmodule KnockoutApi.Tournament do
  alias KnockoutApi.{Repo, Match, MatchGroup}
  use KnockoutApi.Web, :model

  schema "tournaments" do
    field :name, :string
    field :game_id, :string
    has_many :match_groups, KnockoutApi.MatchGroup
    has_many :followings, KnockoutApi.Following

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def matches_count(tournament) do
    Repo.all(from m in Match,
      select: count(m.id),
        join: mg in MatchGroup,
        on: mg.id == m.match_group_id,
        where: mg.tournament_id == ^(tournament.id)
    )
  end
end
