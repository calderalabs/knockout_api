defmodule KnockoutApi.SpoilersView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :match_group_id, :match_id]
end
