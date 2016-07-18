defmodule KnockoutApi.MatchesView do
  alias KnockoutApi.{Spoiler, Repo}
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView
  import Ecto.Query

  has_many :spoilers, include: true, serializer: KnockoutApi.SpoilersView

  attributes [:winner_id, :match_group_id, :number, :like_count, :vod]

  def spoilers(match, conn) do
    Repo.all(from s in Spoiler,
      where: s.match_id == ^(match.id) and s.user_id == ^(conn.assigns.opts.current_user.id)
    )
  end
end
