defmodule KnockoutApi.AdminMatchesView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:match_group_id, :number, :vod]

  has_one :winner, include: true, serializer: KnockoutApi.AdminTeamsView

  def type(_following, _conn), do: "match"
end
