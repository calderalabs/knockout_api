defmodule KnockoutApi.TheScore.Server do
  use GenServer

  @timeout_in_ms Application.get_env(:knockout_api, :api_timeout_in_ms)
  
  # Public API

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def fetch_matches(game) do
    GenServer.call(__MODULE__, {:fetch_matches, game}, @timeout_in_ms)
  end

  # Private API

  def handle_call({:fetch_matches, game}, _from, state) do
    result = KnockoutApi.TheScore.Client.fetch_matches(game)
    {:reply, result, state}
  end
end
