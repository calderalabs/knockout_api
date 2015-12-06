defmodule KnockoutApi.TheScore.Client do
  use Timex

  @base_url "http://esports-api.thescore.com"
  @endpoint "matches"

  def fetch_match_groups(game) do
    case HTTPoison.get(url_for(game)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> get_results |> normalize_results}
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

  defp match_groups_transform_map do
    %{
      "start_date" => %{
        "key" => "start_at",
        "value" => &convert_iso_string/1
      },
      "end_date" => %{
        "key" => "end_at",
        "value" => &convert_iso_string/1
      },
      "max_games" => %{
        "key" => "best_of",
        "value" => &(&1)
      },
      "team1_score" => %{
        "key" => "team1_score",
        "value" => &(&1)
      },
      "team2_score" => %{
        "key" => "team2_score",
        "value" => &(&1)
      },
      "team1_url" => %{
        "key" => "team1_id",
        "value" => &extract_id_from_url/1
      },
      "team2_url" => %{
        "key" => "team2_id",
        "value" => &extract_id_from_url/1
      },
      "winning_team_url" => %{
        "key" => "winning_team_id",
        "value" => &extract_id_from_url/1
      }
    }
  end

  defp extract_id_from_url(url) do
    case url do
      nil -> nil
      x -> x |> String.split("/") |> List.last
    end
  end

  defp convert_iso_string(string) do
    {:ok, date} = string |> DateFormat.parse("{ISO}")
    date
  end

  defp get_results(body) do
    body
      |> Poison.decode!
      |> Dict.get("matches")
      |> Enum.map(fn (hash) ->
          Dict.take(hash, Dict.keys(match_groups_transform_map))
        end)
  end

  defp normalize_results(results) do
    Enum.map(results, fn(result) ->
      Enum.reduce(result, %{}, fn({key, value}, acc) ->
        transform = get_transform_for(key)

        new_value = case value do
          nil -> nil
          x -> transform["value"].(x)
        end

        Dict.put(acc, transform["key"], new_value)
      end)
    end)
  end

  defp get_transform_for(key) do
    Dict.get(match_groups_transform_map, key, %{
      "key" => key, "value" => &(&1)
    })
  end
end
