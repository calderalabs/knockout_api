defmodule KnockoutApi.TournamentsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :game_id]

  has_many :followings, include: true, serializer: KnockoutApi.FollowingsView
  has_many :match_groups, include: true, serializer: KnockoutApi.MatchGroupsView

  def followings(_tournament, conn) do
    conn.assigns.opts.followings
  end
end
