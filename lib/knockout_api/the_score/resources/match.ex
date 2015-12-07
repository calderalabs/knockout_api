defmodule KnockoutApi.TheScore.Resources.Match do
  import KnockoutApi.TheScore.Transformations

  def transform_map do
    %{
      "id" => %{
        "key" => "id",
        "value" => &(&1)
      },
      "game_number" => %{
        "key" => "match_number",
        "value" => &(&1)
      },
      "match_url" => %{
        "key" => "match_group_id",
        "value" => &extract_id_from_url/1
      },
      "winning_team_url" => %{
        "key" => "winning_team_id",
        "value" => &extract_id_from_url/1
      }
    }
  end
end
