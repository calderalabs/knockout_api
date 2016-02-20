defmodule KnockoutApi.TheScore.Client do
  use Timex
  import Parallel
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
        {:ok, body |> get_results(game)}
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
    {:ok, start_date_from} = Date.now
      |> Date.subtract(Time.to_timestamp(10, :days))
      |> DateFormat.format("{YYYY}-{M}-{D}T00:00:00+0000")

    {:ok, start_date_to} = Date.now |> DateFormat.format("{YYYY}-{M}-{D}T00:00:00+0000")

    %{
      "start_date_from" => start_date_from,
      "start_date_to" => start_date_to
    } |> build_query
  end

  defp build_query(query) do
    query
      |> Enum.to_list
      |> Enum.map(fn({key, value}) -> "#{key}=#{value}" end)
      |> Enum.join("&")
  end

  defp url_for_match_group(game, match_group) do
    "#{@base_url}/#{game}/#{@endpoint}/#{match_group["id"]}"
  end

  defp get_results(body, game) do
    body
      |> Poison.decode!
      |> Transformations.transform(MatchGroup.transform_map, "matches", "match_groups")
      |> Transformations.transform(Team.transform_map, "teams", "teams")
      |> Transformations.transform(Tournament.transform_map, "competitions", "tournaments")
      |> Transformations.transform(Season.transform_map, "seasons", "seasons")
      |> Transformations.merge("tournaments", "seasons", "season_id")
      |> put_matches(game)
  end

  defp put_matches(body, game) do
    body
      |> Dict.put("matches", fetch_all_matches(body, game))
      |> Dict.drop(["games"])
  end

  defp fetch_all_matches(body, game) do
    Parallel.map(body["match_groups"], fn(match_group) ->
      case HTTPoison.get(url_for_match_group(game, match_group), [], [timeout: @timeout_in_ms, recv_timeout: @timeout_in_ms]) do
        {:ok, %HTTPoison.Response{status_code: 200, body: match_group_body}} ->
          match_group_body
            |> Poison.decode!
            |> Transformations.transform(Match.transform_map, "games", "matches")
            |> Dict.get("matches")
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          {:error, %{reason: "Not found"}}
        {:error, %HTTPoison.Error{reason: reason}} ->
          {:error, %{reason: reason}}
      end
    end) |> List.flatten
  end
end
