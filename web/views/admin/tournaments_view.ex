defmodule KnockoutApi.AdminTournamentsView do
  use KnockoutApi.Web, :view

  attributes [:name, :game_id, :current_stage]

  has_many :match_groups, include: true, serializer: KnockoutApi.AdminMatchGroupsView

  def type(_following, _conn), do: "tournament"
end
