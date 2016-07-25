defmodule KnockoutApi.MatchesView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView
  has_many :watchings, include: true, serializer: KnockoutApi.WatchingsView
  has_many :likes, include: true, serializer: KnockoutApi.LikesView

  attributes [:winner_id, :match_group_id, :number, :likes_count, :vod]

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
end
