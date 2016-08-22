defmodule KnockoutApi.Tournament do
  alias KnockoutApi.{Repo, Match, MatchGroup}
  use KnockoutApi.Web, :model

  schema "tournaments" do
    field :name, :string
    field :game_id, :string
    field :current_stage, :string
    field :draft, :boolean
    has_many :match_groups, KnockoutApi.MatchGroup, on_delete: :delete_all
    has_many :followings, KnockoutApi.Following, on_delete: :delete_all

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name game_id current_stage draft)a)
    |> validate_required(~w(name game_id draft)a)
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
