defmodule KnockoutApi.WatchingsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:match_id]
end
