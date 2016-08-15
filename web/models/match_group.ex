defmodule KnockoutApi.MatchGroup do
  use KnockoutApi.Web, :model
  use Timex

  schema "match_groups" do
    field :started_at, Timex.Ecto.DateTime
    field :best_of, :integer
    field :stage, :string
    belongs_to :tournament, KnockoutApi.Tournament
    belongs_to :team_one, KnockoutApi.Team
    belongs_to :team_two, KnockoutApi.Team
    has_many :matches, KnockoutApi.Match
    has_many :spoilers, KnockoutApi.Spoiler

    timestamps
  end

  @required_fields ~w(tournament_id team_one_id team_two_id best_of stage)a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
