defmodule KnockoutApi.BaseController do
  alias KnockoutApi.{Repo, User}
  import Ecto.Query

  def current_user do
    Repo.one(from u in User, limit: 1)
  end
end
