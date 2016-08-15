defmodule KnockoutApi.FollowingsView do
  alias KnockoutApi.Following
  use KnockoutApi.Web, :view

  has_one :tournament, include: true, serializer: KnockoutApi.TournamentsView

  attributes [:new_matches_count, :seen_at]

  def new_matches_count(following, _conn) do
    Following.new_matches_count(following)
  end
end
