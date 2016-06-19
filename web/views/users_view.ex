defmodule KnockoutApi.UsersView do
  use KnockoutApi.Web, :view
  use JaSerializer.PhoenixView

  attributes [:name]
end
