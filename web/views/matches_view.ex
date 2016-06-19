defmodule KnockoutApi.MatchesView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:winner_id, :match_group_id, :number, :like_count, :vod]
end
