defmodule KnockoutApi.BaseController do
  alias KnockoutApi.{Repo, User}
  import Ecto.Query

  def current_user do
    Repo.all(from u in User, limit: 1) |> List.first
  end
end
