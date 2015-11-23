defmodule Liquipedia do
  @game "dota2"
  @base_url "http://wiki.teamliquid.net"
  @endpoint "api.php"

  def url do
    "#{@base_url}/#{@game}/#{@endpoint}?#{params}"
  end

  defp params do
    %{
      "action" => "askargs",
      "conditions" => "Category:Tournaments",
      "format" => "json",
      "parameters" => ["sort=Has_start_date", "order=desc", "offset=0", "limit=20"],
      "printouts" => Dict.keys(tournaments_transform_map)
    } |> build_params
  end

  defp build_params(params) do
    Enum.reduce(params, [], fn ({key, value}, acc) ->
      case value do
        x when is_list(x) -> acc ++ ["#{key}=#{Enum.join(x, "|")}"]
        x -> acc ++ ["#{key}=#{x}"]
      end
    end) |> Enum.join("&")
  end

  def fetch_tournaments do
    %HTTPoison.Response{ body: body } = HTTPoison.get!(url)
    body |> get_results |> normalize_results
  end

  defp tournaments_transform_map do
    %{
      "Has_start_date" => %{
        "key" => "start_at",
        "value_transform" => &convert_unix_timestamp/1
      },
      "Has_end_date" => %{
        "key" => "end_at",
        "value_transform" => &convert_unix_timestamp/1
      },
      "Has_name" => %{
        "key" => "name",
        "value_transform" => &(&1)
      },
      "Has_id" => %{
        "key" => "liquipedia_id",
        "value_transform" => &(&1)
      }
    }
  end

  defp get_results(body) do
    body
      |> Poison.decode!
      |> get_in(~w(query results))
      |> Enum.map(fn ({_, hash}) ->
        Dict.take(hash["printouts"], Dict.keys(tournaments_transform_map))
      end)
  end

  defp convert_unix_timestamp(string) do
    epoch = {{1970, 1, 1}, {0, 0, 0}}
    offset = :calendar.datetime_to_gregorian_seconds(epoch)
    {uts, _} = Integer.parse(string)
    :calendar.gregorian_seconds_to_datetime(uts + offset)
  end

  defp normalize_results(results) do
    Enum.map(results, fn(result) ->
      Enum.reduce(result, %{}, fn({key, value}, acc) ->
        transform = Dict.fetch!(tournaments_transform_map, key)
        new_key = transform["key"]

        new_value = case value do
          [x] -> transform["value_transform"].(x)
          [] -> nil
        end

        Dict.put(acc, new_key, new_value)
      end)
    end)
  end
end
