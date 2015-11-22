defmodule KnockoutApi.TournamentsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :game_id]

  has_one :game,
    serializer: KnockoutApi.GameSerializer,
    include: true
end
