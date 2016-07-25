defmodule KnockoutApi.TournamentsView do
  alias KnockoutApi.Tournament
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :game_id, :matches_count]

  has_many :followings, include: true, serializer: KnockoutApi.BasicFollowingsView
  has_many :match_groups, links: [related: "/match_groups?tournament_id=:id"]

  def followings(tournament, conn) do
    Enum.filter(conn.assigns.opts.followings, fn(f) ->
      f.tournament_id == tournament.id
    end)
  end

  def matches_count(tournament, _conn) do
    Tournament.matches_count(tournament)
  end
end
