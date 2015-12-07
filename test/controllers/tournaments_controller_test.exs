defmodule KnockoutApi.TournamentsControllerTest do
  alias KnockoutApi.Tournament
  use KnockoutApi.ConnCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  test "GET /tournaments" do
    use_cassette "the_score_dota2_tournaments" do
      game = KnockoutApi.Game.find_or_create_by_name("Dota 2")
      Tournament.create(%{ game_id: game.id, name: "Test Tournament" })
      body = conn()
        |> put_req_header("accept", "application/vnd.api+json")
        |> get("/tournaments")
        |> json_response(200)

      assert Enum.count(body["tournaments"]) != 0
      assert Enum.count(body["teams"]) != 0
      assert Enum.count(body["matches"]) != 0
      assert Enum.count(body["match_groups"]) !=0
    end
  end
end
