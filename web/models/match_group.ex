defmodule KnockoutApi.MatchGroup do
  use KnockoutApi.Web, :model

  schema "match_groups" do
    belongs_to :tournament, KnockoutApi.Tournament
    belongs_to :team_one, KnockoutApi.Team
    belongs_to :team_two, KnockoutApi.Team
    belongs_to :winner, KnockoutApi.Team
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime
    field :vods, {:array, :map}
    field :best_of, :integer
    field :the_score_id, :integer

    timestamps
  end

  @required_fields ~w(tournament_id team_one_id team_two_id best_of the_score_id)
  @optional_fields ~w(winner_id start_at end_at vods)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:the_score_id)
  end
end
