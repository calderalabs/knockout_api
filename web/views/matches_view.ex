defmodule KnockoutApi.MatchesView do
  use KnockoutApi.Web, :view

  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView
  has_many :watchings, include: true, serializer: KnockoutApi.WatchingsView
  has_many :likes, include: true, serializer: KnockoutApi.LikesView
  has_one :winner, include: true, serializer: KnockoutApi.TeamsView

  attributes [:match_group_id, :number, :likes_count, :vod]

  def spoilers(match, conn) do
    Enum.filter(conn.assigns.opts.matches_spoilers, fn(s) ->
      s.match_id == match.id
    end)
  end

  def watchings(match, conn) do
    Enum.filter(conn.assigns.opts.watchings, fn(w) ->
      w.match_id == match.id
    end)
  end

  def likes(match, conn) do
    Enum.filter(conn.assigns.opts.likes, fn(l) ->
      l.match_id == match.id
    end)
  end

  def winner(match, conn) do
    Enum.filter(conn.assigns.opts.teams, fn(t) ->
      t.id == match.winner_id
    end) |> List.first
  end
end
