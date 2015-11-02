defmodule KnockoutApi.TournamentsControllerTest do
  alias KnockoutApi.Tournament
  use KnockoutApi.ConnCase

  test "GET /tournaments" do
    game = KnockoutApi.Game.find_or_create_by_name("Dota 2")
    Tournament.create(%{ game: game, name: "Test Tournament" })
    body = conn()
           |> put_req_header("accept", "application/vnd.api+json")
           |> get("/tournaments")
           |> json_response(200)

    assert Enum.at(body["data"], 0)["attributes"]["name"] == "Test Tournament"
    assert Enum.at(body["data"], 0)["attributes"]["game_id"] == game.id
  end
end
