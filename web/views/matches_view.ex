defmodule KnockoutApi.MatchesView do
  alias KnockoutApi.{Spoiler, Repo, Watching, Like}
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView
  has_many :watchings, include: true, serializer: KnockoutApi.WatchingsView
  has_many :likes, include: true, serializer: KnockoutApi.LikesView

  attributes [:winner_id, :match_group_id, :number, :likes_count, :vod]

  def spoilers(match, conn) do
    Spoiler.for_user(Ecto.assoc(match, :spoilers), conn.assigns.opts.current_user)
  end

  def watchings(match, conn) do
    Watching.for_user(Ecto.assoc(match, :watchings), conn.assigns.opts.current_user)
  end

  def likes(match, conn) do
    Like.for_user(Ecto.assoc(match, :likes), conn.assigns.opts.current_user)
  end
end
