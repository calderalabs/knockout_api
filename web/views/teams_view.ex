defmodule KnockoutApi.TeamsView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:full_name, :short_name, :logo_url]
end
