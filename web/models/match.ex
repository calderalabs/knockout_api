defmodule KnockoutApi.Match do
  use KnockoutApi.Web, :model

  schema "matches" do
    belongs_to :winner, KnockoutApi.Team
    belongs_to :match_group, KnockoutApi.MatchGroup
    has_many :spoilers, KnockoutApi.Spoiler
    field :number, :integer
    field :like_count, :integer
    field :vod, :map

    timestamps
  end

  @required_fields ~w(match_group_id number)
  @optional_fields ~w(winner_id)

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
