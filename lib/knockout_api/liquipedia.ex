defmodule Liquipedia do
  @base_url "http://wiki.teamliquid.net"
  @endpoint "api.php"

  def fetch_tournaments(game) do
    %HTTPoison.Response{ body: body } = HTTPoison.get!(url(game))
    body |> get_results |> normalize_results
  end

  defp url(game) do
    "#{@base_url}/#{game}/#{@endpoint}?#{params}"
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

  defp tournaments_transform_map do
    %{
      "Has_start_date" => %{
        "key" => "start_at",
        "value" => &convert_unix_timestamp/1
      },
      "Has_end_date" => %{
        "key" => "end_at",
        "value" => &convert_unix_timestamp/1
      },
      "Has_name" => %{
        "key" => "name",
        "value" => &(&1)
      }
    }
  end

  defp get_results(body) do
    body
      |> Poison.decode!
      |> get_in(~w(query results))
      |> Enum.map(fn ({id, hash}) ->
        Dict.take(hash["printouts"], Dict.keys(tournaments_transform_map))
        |> Dict.put("liquipedia_id", id)
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
        transform = case Dict.fetch(tournaments_transform_map, key) do
          {:ok, dict} -> dict
          :error -> %{ "key" => key, "value" => &(&1) }
        end

        new_key = transform["key"]

        new_value = case value do
          [x] -> transform["value"].(x)
          [] -> nil
          x -> transform["value"].(x)
        end

        Dict.put(acc, new_key, new_value)
      end)
    end)
  end
end
