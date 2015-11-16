defmodule KnockoutApi.MatchGroup do
  use KnockoutApi.Web, :model

  schema "match_groups" do
    belongs_to :tournament, KnockoutApi.Tournament
    belongs_to :team_one, KnockoutApi.Team
    belongs_to :team_two, KnockoutApi.Team
    has_many :matches, KnockoutApi.Match
    field :best_of, :string
    field :elimination, :boolean, default: false

    timestamps
  end

  @required_fields ~w(tournament_id team_one_id team_two_id best_of elimination)
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
