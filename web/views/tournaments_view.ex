defmodule KnockoutApi.TournamentsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :game_id]
end
