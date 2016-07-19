defmodule KnockoutApi.FollowingsView do
  alias KnockoutApi.Following
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tournament_id, :new_matches_count, :seen_at]

  def new_matches_count(following, _conn) do
    Following.new_matches_count(following)
  end
end
