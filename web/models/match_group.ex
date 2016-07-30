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

  @required_fields ~w(tournament_id team_one_id team_two_id best_of stage)
  @optional_fields ~w(started_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> convert_started_at_to_utc
  end

  defp convert_started_at_to_utc(changeset) do
    case get_change(changeset, :started_at) do
      nil -> changeset
      started_at -> put_change(changeset, :started_at, Timex.Timezone.convert(started_at, "Etc/UTC"))
    end
  end
end
