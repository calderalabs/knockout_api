defmodule KnockoutApi.LiquipediaServerTest do
  use ExUnit.Case, async: false
  import Mock

  test "#fetch_tournaments respects API rate limit" do
    with_mock KnockoutApi.Liquipedia.Client,
      [fetch_tournaments: fn(game) -> {:ok, %{game: "dota2"}} end] do

      first = Task.async fn ->
        KnockoutApi.Liquipedia.Server.fetch_tournaments("dota2")
      end
      first_ref = Process.monitor(first.pid)

      second = Task.async fn ->
        KnockoutApi.Liquipedia.Server.fetch_tournaments("dota2")
      end
      second_ref = Process.monitor(second.pid)

      assert_receive {:DOWN, ^first_ref, :process, _, :normal}, 80
      refute_receive {:DOWN, ^second_ref, :process, _, :normal}, 80
    end
  end
end
