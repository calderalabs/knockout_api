defmodule KnockoutApi.AdminMatchGroupsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tournament_id, :started_at, :best_of, :stage]

  has_one :team_one, include: true, serializer: KnockoutApi.AdminTeamsView
  has_one :team_two, include: true, serializer: KnockoutApi.AdminTeamsView
  has_many :matches, include: true, serializer: KnockoutApi.AdminMatchesView

  def type(_following, _conn), do: "match_group"
end
