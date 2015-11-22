defmodule KnockoutApi.Tournament do
  alias KnockoutApi.Tournament
  alias KnockoutApi.Repo

  use KnockoutApi.Web, :model

  schema "tournaments" do
    field :name, :string
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime
    belongs_to :game, KnockoutApi.Game
    has_many :match_groups, KnockoutApi.MatchGroup
    has_many :teams, KnockoutApi.Team

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w(start_at end_at)

  def create(tournament) do
    Repo.insert(Tournament.changeset(%Tournament{}, %{
      name: tournament.name, game_id: tournament.game_id
    }))
  end

  def liquipedia_transform_map do
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
      }
    }
  end

  def liquipedia_url do
    "http://wiki.teamliquid.net/dota2/api.php?action=askargs&conditions=Category:Tournaments&format=json&parameters=sort=Has_start_date|order=desc|offset=0|limit=20&printouts=Has_teams|Has_name|Has_start_date|Has_end_date|Has_format"
  end

  def import_from_liquipedia do
    %HTTPoison.Response{ body: body } = HTTPoison.get!(liquipedia_url)
    body |> get_results |> normalize_results
  end

  def get_results(body) do
    body
      |> Poison.decode!
      |> get_in(~w(query results))
      |> Enum.map(fn ({_, hash}) ->
        Dict.take(hash["printouts"], Dict.keys(liquipedia_transform_map))
      end)
  end

  def convert_unix_timestamp(string) do
    epoch = {{1970, 1, 1}, {0, 0, 0}}
    offset = :calendar.datetime_to_gregorian_seconds(epoch)
    {uts, _} = Integer.parse(string)
    :calendar.gregorian_seconds_to_datetime(uts + offset)
  end

  def normalize_results(results) do
    Enum.map(results, fn(result) ->
      Enum.reduce(result, %{}, fn({key, array}, acc) ->
        transform = Dict.fetch!(liquipedia_transform_map, key)
        new_key = transform["key"]

        new_value = case array do
          [value] -> transform["value_transform"].(value)
          [] -> nil
        end

        Dict.put(acc, new_key, new_value)
      end)
    end)
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> foreign_key_constraint(:game_id)
    |> unique_constraint(:name)
  end
end
