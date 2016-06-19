defmodule KnockoutApi.MatchGroupsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tournament_id, :start_at, :best_of]

  has_one :team_one, include: true, serializer: KnockoutApi.TeamsView
  has_one :team_two, include: true, serializer: KnockoutApi.TeamsView
  has_many :matches, include: true, serializer: KnockoutApi.MatchesView
end
