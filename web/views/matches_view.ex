defmodule KnockoutApi.MatchesView do
  alias KnockoutApi.{Spoiler, Repo, Watching}
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView
  import Ecto.Query

  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView
  has_many :watchings, include: true, serializer: KnockoutApi.WatchingsView

  attributes [:winner_id, :match_group_id, :number, :like_count, :vod]

  def spoilers(match, conn) do
    Spoiler.for_user((from s in Spoiler, where: s.match_id == ^(match.id)), conn.assigns.opts.current_user)
  end

  def watchings(match, conn) do
    Watching.for_user((from w in Watching, where: w.match_id == ^(match.id)), conn.assigns.opts.current_user)
  end
end
