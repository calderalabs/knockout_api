defmodule KnockoutApi.BaseController do
  alias KnockoutApi.User

  def current_user(conn) do
    case Plug.Conn.get_req_header(conn, "authorization") do
      [] -> nil
      authorization_header ->
        authorization_header
        |> List.first
        |> String.split
        |> List.last
        |> User.find_or_create(conn.assigns[:credentials])
    end
  end
end
