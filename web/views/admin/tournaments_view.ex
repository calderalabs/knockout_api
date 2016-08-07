defmodule KnockoutApi.AdminTournamentsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :game_id, :current_stage]

  def type(_following, _conn), do: "tournament"
end
