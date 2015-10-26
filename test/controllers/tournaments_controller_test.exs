defmodule KnockoutApi.PageControllerTest do
  alias KnockoutApi.Tournament
  use KnockoutApi.ConnCase

  test "GET /" do
    Tournament.create(%{ game: "dota2", name: "Test Tournament" })
    body = conn()
           |> put_req_header("accept", "application/vnd.api+json")
           |> get("/tournaments")
           |> json_response(200)

    assert Enum.at(body["data"], 0)["attributes"]["name"] == "Test Tournament"
  end
end
