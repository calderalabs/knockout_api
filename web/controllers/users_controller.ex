defmodule KnockoutApi.UsersController do
  alias KnockoutApi.{Repo, User}
  use KnockoutApi.Web, :controller
  import KnockoutApi.BaseController

  def show(conn, %{ "id" => id }) do
    # render conn, data: Repo.get!(User, id)
    render conn, data: current_user
  end
end
