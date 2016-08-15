defmodule KnockoutApi.BasicFollowingsView do
  alias KnockoutApi.Following
  use KnockoutApi.Web, :view

  attributes [:tournament_id, :new_matches_count, :seen_at]

  def type(_following, _conn), do: "following"

  def new_matches_count(following, _conn) do
    Following.new_matches_count(following)
  end
end
