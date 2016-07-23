defmodule KnockoutApi.TournamentsView do
  alias KnockoutApi.{Following, Tournament}
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :game_id, :matches_count]

  has_many :followings, include: true, serializer: KnockoutApi.FollowingsView
  has_many :match_groups, include: true, serializer: KnockoutApi.MatchGroupsView

  def followings(tournament, conn) do
    Following.for_user(Ecto.assoc(tournament, :followings), conn.assigns.opts.current_user)
  end

  def matches_count(tournament, _conn) do
    Tournament.matches_count(tournament)
  end
end
