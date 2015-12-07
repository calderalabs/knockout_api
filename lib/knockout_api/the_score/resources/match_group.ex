defmodule KnockoutApi.TheScore.Resources.MatchGroup do
  import KnockoutApi.TheScore.Transformations

  def transform_map do
    %{
      "id" => %{
        "key" => "id",
        "value" => &(&1)
      },
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
        "key" => "team_one_score",
        "value" => &(&1)
      },
      "team2_score" => %{
        "key" => "team_two_score",
        "value" => &(&1)
      },
      "team1_url" => %{
        "key" => "team_one_id",
        "value" => &extract_id_from_url/1
      },
      "team2_url" => %{
        "key" => "team_two_id",
        "value" => &extract_id_from_url/1
      },
      "winning_team_url" => %{
        "key" => "winner_id",
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
