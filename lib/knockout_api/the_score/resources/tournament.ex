defmodule KnockoutApi.TheScore.Resources.Tournament do
  import KnockoutApi.TheScore.Transformations

  def transform_map do
    %{
      "id" => %{
        "key" => "the_score_id",
        "value" => &(&1)
      },
      "current_season_url" => %{
        "key" => "season_id",
        "value" => &extract_id_from_url/1
      }
    }
  end
end
