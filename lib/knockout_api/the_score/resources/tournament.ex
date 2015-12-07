defmodule KnockoutApi.TheScore.Resources.Tournament do
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
      "short_name" => %{
        "key" => "name",
        "value" => &(&1)
      }
    }
  end
end
