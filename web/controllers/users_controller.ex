defmodule KnockoutApi.UsersController do
  use KnockoutApi.Web, :controller
  import KnockoutApi.BaseController

  def show(conn, _params) do
    render conn, data: current_user(conn)
  end
end
