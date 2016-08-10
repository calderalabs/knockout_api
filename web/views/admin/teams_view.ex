defmodule KnockoutApi.AdminTeamsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:short_name, :full_name, :logo_url]

  def type(_following, _conn), do: "team"
end
