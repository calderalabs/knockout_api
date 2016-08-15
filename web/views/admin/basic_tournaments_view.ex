defmodule KnockoutApi.AdminBasicTournamentsView do
  use KnockoutApi.Web, :view

  attributes [:name, :game_id, :current_stage]

  def type(_following, _conn), do: "tournament"
end
