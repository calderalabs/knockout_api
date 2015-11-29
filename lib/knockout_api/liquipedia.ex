defmodule KnockoutApi.Liquipedia do
  @base_url "http://wiki.teamliquid.net"
  @endpoint "api.php"

  def fetch_tournaments(game) do
    case HTTPoison.get(url_for(game)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> get_results |> normalize_results}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, %{reason: "Not found"}}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %{reason: reason}}
    end
  end

  defp url_for(game) do
    "#{@base_url}/#{game}/#{@endpoint}?#{query}"
  end

  defp query do
    %{
      "action" => "askargs",
      "conditions" => "Category:Tournaments",
      "format" => "json",
      "parameters" => ["sort=Has_start_date", "order=desc", "offset=0", "limit=20"],
      "printouts" => Dict.keys(tournaments_transform_map)
    } |> build_query
  end

  defp build_query(query) do
    query
      |> Enum.to_list
      |> Enum.map(fn({key, value}) ->
          case value do
            x when is_list(x) -> "#{key}=#{Enum.join(x, "|")}"
            x -> "#{key}=#{x}"
          end
        end)
      |> Enum.join("&")
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
        |> Dict.put("liquipedia_id", [id])
      end)
  end

  defp epoch_datetime do
    {{1970, 1, 1}, {0, 0, 0}}
  end

  defp epoch_seconds do
    :calendar.datetime_to_gregorian_seconds(epoch_datetime)
  end

  defp convert_unix_timestamp(string) do
    {uts, _} = Integer.parse(string)
    :calendar.gregorian_seconds_to_datetime(uts + epoch_seconds)
  end

  defp normalize_results(results) do
    Enum.map(results, fn(result) ->
      Enum.reduce(result, %{}, fn({key, value}, acc) ->
        transform = get_transform_for(key)

        new_value = case value do
          [x] -> transform["value"].(x)
          []  -> nil
        end

        Dict.put(acc, transform["key"], new_value)
      end)
    end)
  end

  defp get_transform_for(key) do
    case Dict.fetch(tournaments_transform_map, key) do
      {:ok, dict} -> dict
      :error      -> %{ "key" => key, "value" => &(&1) }
    end
  end
end
