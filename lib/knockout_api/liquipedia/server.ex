defmodule KnockoutApi.Liquipedia.Server do
  use GenServer

  @timeout_in_ms Application.get_env(:knockout_api, :api_timeout_in_ms)
  @rate_limit_in_ms Application.get_env(:knockout_api, :api_rate_limit_in_ms)

  # Public API

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def fetch_tournaments(game) do
    GenServer.call(__MODULE__, {:fetch_tournaments, game}, @timeout_in_ms)
  end

  # Private API

  def handle_call({:fetch_tournaments, game}, _from, state) do
    result = KnockoutApi.Liquipedia.Client.fetch_tournaments(game)
    :timer.sleep(@rate_limit_in_ms)
    {:reply, result, state}
  end
end
