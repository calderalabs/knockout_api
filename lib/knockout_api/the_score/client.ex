defmodule KnockoutApi.TheScore.Client do
  alias KnockoutApi.TheScore.Resources.MatchGroup
  alias KnockoutApi.TheScore.Resources.Match
  alias KnockoutApi.TheScore.Resources.Team
  alias KnockoutApi.TheScore.Resources.Tournament
  alias KnockoutApi.TheScore.Resources.Season
  alias KnockoutApi.TheScore.Transformations

  @base_url "http://esports-api.thescore.com"
  @endpoint "matches"
  @timeout_in_ms Application.get_env(:knockout_api, :api_timeout_in_ms)

  def fetch_matches(game) do
    case HTTPoison.get(url_for(game), [], [timeout: @timeout_in_ms, recv_timeout: @timeout_in_ms]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> get_results}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{reason: "Not found"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}
    end
  end

  defp url_for(game) do
    "#{@base_url}/#{game}/#{@endpoint}?#{query}"
  end

  defp query do
    %{
      "start_date_from" => "2015-11-01T00:00:00+0000"
    } |> build_query
  end

  defp build_query(query) do
    query
      |> Enum.to_list
      |> Enum.map(fn({key, value}) -> "#{key}=#{value}" end)
      |> Enum.join("&")
  end

  defp get_results(body) do
    body
      |> Poison.decode!
      |> Transformations.transform(MatchGroup.transform_map, "matches", "match_groups")
      |> Transformations.transform(Match.transform_map, "games", "matches")
      |> Transformations.transform(Team.transform_map, "teams", "teams")
      |> Transformations.transform(Tournament.transform_map, "competitions", "tournaments")
      |> Transformations.transform(Season.transform_map, "seasons", "seasons")
      |> Transformations.merge("tournaments", "seasons", "season_id")
  end
end
