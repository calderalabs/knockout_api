defmodule KnockoutApi.MatchGroupsView do
  use KnockoutApi.Web, :view

  attributes [:tournament_id, :started_at, :best_of, :stage]

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

  def team_one(match_group, conn) do
    Enum.filter(conn.assigns.opts.teams, fn(t) ->
      t.id == match_group.team_one_id
    end) |> List.first
  end

  def team_two(match_group, conn) do
    Enum.filter(conn.assigns.opts.teams, fn(t) ->
      t.id == match_group.team_two_id
    end) |> List.first
  end
end
