defmodule KnockoutApi.TheScore.Client do
  alias KnockoutApi.TheScore.Resources

  @base_url "http://esports-api.thescore.com"
  @endpoint "matches"

  def fetch_matches(game) do
    case HTTPoison.get(url_for(game)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> get_results}
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
      "start_date_from" => "2015-11-01T00:00:00+0000"
    } |> build_query
  end

  defp build_query(query) do
    query
      |> Enum.to_list
      |> Enum.map(fn({key, value}) -> "#{key}=#{value}" end)
      |> Enum.join("&")
  end

  defp get_results(body) do
    body
      |> Poison.decode!
      |> Resources.MatchGroup.transform
  end
end