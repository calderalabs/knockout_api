defmodule KnockoutApi.TheScore.Resources.Team do
  def transform_map do
    %{
      "id" => %{
        "key" => "id",
        "value" => &(&1)
      },
      "full_name" => %{
        "key" => "full_name",
        "value" => &(&1)
      },
      "short_name" => %{
        "key" => "short_name",
        "value" => &(&1)
      },
      "country" => %{
        "key" => "country",
        "value" => &(&1)
      },
      "logo" => %{
        "key" => "logo",
        "value" => &(&1)
      }
    }
  end
end
