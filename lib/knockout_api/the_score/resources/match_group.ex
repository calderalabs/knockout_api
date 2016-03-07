defmodule KnockoutApi.TheScore.Resources.MatchGroup do
  import KnockoutApi.TheScore.Transformations

  def transform_map do
    %{
      "id" => %{
        "key" => "the_score_id",
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
      "competition_url" => %{
        "key" => "tournament_id",
        "value" => &extract_id_from_url/1
      },
      "game_streams" => %{
        "key" => "vods",
        "value" => fn (vods) ->
          vods
            |> Enum.map(fn (vod) ->
              Enum.map(vod["streams"], fn (sub_vod) ->
                sub_vod
                  |> Dict.put("label", "#{vod["game_label"]} - #{sub_vod["label"]}")
                  |> rename_key("link", "url")
                  |> rename_key("source", "type")
              end)
            end)
            |> List.flatten
        end
      }
    }
  end
end
