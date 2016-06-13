defmodule KnockoutApi.FollowingsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:tournament_id]
end
