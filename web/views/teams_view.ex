defmodule KnockoutApi.TeamsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name, :logo_1x_url, :logo_2x_url]
end
