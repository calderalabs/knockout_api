defmodule KnockoutApi.LiquipediaTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup_all do
    HTTPoison.start
  end

  test "#fetch_tournaments fetches and parses tournaments from liquipedia" do
    use_cassette "dota2_tournaments" do
      {:ok, tournaments} = KnockoutApi.Liquipedia.Client.fetch_tournaments("dota2")

      assert Enum.count(tournaments) == 20
      assert List.first(tournaments) == %{
        "end_at" => {{2015, 11, 16}, {0, 0, 0}},
        "liquipedia_id" => "Anzac Dota Captains Draft",
        "name" => "Anzac DotA Captains Draft",
        "start_at" => {{2015, 11, 13}, {0, 0, 0}}
      }
    end
  end
end
