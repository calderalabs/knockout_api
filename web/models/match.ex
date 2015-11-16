defmodule KnockoutApi.Match do
  use KnockoutApi.Web, :model

  schema "matches" do
    belongs_to :team_one, KnockoutApi.Team
    belongs_to :team_two, KnockoutApi.Team
    belongs_to :winner, KnockoutApi.Team
    belongs_to :match_group, KnockoutApi.MatchGroup

    timestamps
  end

  @required_fields ~w(team_one_id team_two_id winner_id match_group_id)
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
end
