defmodule KnockoutApi.TheScore.Resources.MatchGroup do
  import KnockoutApi.TheScore.Transformations

  def transform(matches_response_body) do
    match_groups = matches_response_body
      |> Dict.get("matches")
      |> Enum.map(fn (hash) ->
        Dict.take(hash, Dict.keys(transform_map))
      end)
      |> normalize_results(transform_map)

    matches_response_body
      |> Dict.put("match_groups", match_groups)
      |> Dict.drop(["matches"])
  end

  defp transform_map do
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
      },
      "game_streams" => %{
        "key" => "match_streams",
        "value" => fn (streams) ->
          Enum.map(streams, fn (stream) ->
            rename_key(stream, "game_label", "match_label")
          end)
        end
      }
    }
  end
end
