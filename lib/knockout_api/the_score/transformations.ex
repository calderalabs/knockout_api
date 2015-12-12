defmodule KnockoutApi.TheScore.Transformations do
  use Timex

  defimpl Poison.Encoder, for: [DateTime] do
    def encode(dt, _opts) do
      {:ok, date} = DateFormat.format(dt, "{ISOz}")
      <<?", date::binary, ?">>
    end
  end

  def transform(matches_response_body, transform_map, the_score_resource_key, knockout_resource_key) do
    match_groups = matches_response_body
      |> Dict.get(the_score_resource_key)
      |> Enum.map(fn (hash) ->
        Dict.take(hash, Dict.keys(transform_map))
      end)
      |> normalize_results(transform_map)

    matches = matches_response_body
      |> Dict.put(knockout_resource_key, match_groups)

    if knockout_resource_key != the_score_resource_key do
      matches
        |> Dict.drop([the_score_resource_key])
    else
      matches
    end
  end

  def rename_key(dict, old_key, new_key) do
    dict
      |> Dict.put(new_key, Dict.get(dict, old_key))
      |> Dict.drop([old_key])
  end

  def extract_id_from_url(url) do
    case url do
      nil -> nil
      x -> x |> String.split("/") |> List.last
    end
  end

  def convert_iso_string(string) do
    {:ok, date} = string |> DateFormat.parse("{ISO}")
    date
  end

  def normalize_results(results, transform_map \\ %{}) do
    Enum.map(results, fn(result) ->
      Enum.reduce(result, %{}, fn({key, value}, acc) ->
        transform = get_transform_for(key, transform_map)

        new_value = case value do
          nil -> nil
          x -> transform["value"].(x)
        end

        Dict.put(acc, transform["key"], new_value)
      end)
    end)
  end

  def get_transform_for(key, transform_map \\ %{}) do
    Dict.get(transform_map, key, %{
      "key" => key, "value" => &(&1)
    })
  end
end
