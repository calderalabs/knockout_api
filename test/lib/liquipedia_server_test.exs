defmodule KnockoutApi.LiquipediaServerTest do
  use ExUnit.Case, async: true
  import Mock

  defp fetch_tournaments do
    KnockoutApi.Liquipedia.Server.fetch_tournaments("dota2")
  end

  test "#fetch_tournaments performs in less than the rate limit in ms" do
    with_mock KnockoutApi.Liquipedia.Client,
      [fetch_tournaments: fn(_) -> {:ok, %{game: "dota2"}} end] do

      first = Task.async(&fetch_tournaments/0)
      first_ref = Process.monitor(first.pid)

      assert_receive {:DOWN, ^first_ref, :process, _, :normal}, 900
    end
  end

  test "#fetch_tournaments respects API rate limit" do
    with_mock KnockoutApi.Liquipedia.Client,
      [fetch_tournaments: fn(_) -> {:ok, %{game: "dota2"}} end] do

      _first = Task.async(&fetch_tournaments/0)
      :timer.sleep(50)
      second = Task.async(&fetch_tournaments/0)
      second_ref = Process.monitor(second.pid)

      refute_receive {:DOWN, ^second_ref, :process, _, :normal}, 900
    end
  end
end
