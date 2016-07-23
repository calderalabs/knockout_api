defmodule KnockoutApi.MatchGroupsView do
  alias KnockoutApi.{Repo, Spoiler}
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tournament_id, :started_at, :best_of]

  has_one :team_one, include: true, serializer: KnockoutApi.TeamsView
  has_one :team_two, include: true, serializer: KnockoutApi.TeamsView
  has_many :matches, include: true, serializer: KnockoutApi.MatchesView
  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView

  def spoilers(match_group, conn) do
    Spoiler.for_user(Ecto.assoc(match_group, :spoilers), conn.assigns.opts.current_user)
  end
end
