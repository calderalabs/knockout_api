defmodule KnockoutApi.Match do
  use KnockoutApi.Web, :model

  schema "matches" do
    belongs_to :winner, KnockoutApi.Team
    belongs_to :match_group, KnockoutApi.MatchGroup
    has_many :spoilers, KnockoutApi.Spoiler
    has_many :watchings, KnockoutApi.Watching
    has_many :likes, KnockoutApi.Like
    field :number, :integer
    field :likes_count, :integer
    field :vod, :string

    timestamps
  end

  @required_fields ~w(match_group_id number likes_count vod)a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:vod, ~r/(youtube\.com\/embed)|(twitch.tv\/.*\/v\/)/)
  end
end
