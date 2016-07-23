defmodule KnockoutApi.MatchGroupsView do
  alias KnockoutApi.{Repo, Spoiler}
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tournament_id, :started_at, :best_of]

  has_one :team_one, include: true, serializer: KnockoutApi.TeamsView
  has_one :team_two, include: true, serializer: KnockoutApi.TeamsView
  has_many :matches, include: true, serializer: KnockoutApi.MatchesView
  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView

  def matches(match_group, conn) do
    Enum.filter(conn.assigns.opts.matches, fn(m) ->
      m.match_group_id == match_group.id
    end)
  end

  def spoilers(match_group, conn) do
    Enum.filter(conn.assigns.opts.match_groups_spoilers, fn(s) ->
      s.match_group_id == match_group.id
    end)
  end
end
