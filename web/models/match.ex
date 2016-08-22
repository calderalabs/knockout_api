defmodule KnockoutApi.Match do
  use KnockoutApi.Web, :model

  schema "matches" do
    belongs_to :winner, KnockoutApi.Team
    belongs_to :match_group, KnockoutApi.MatchGroup
    has_many :spoilers, KnockoutApi.Spoiler, on_delete: :delete_all
    has_many :watchings, KnockoutApi.Watching, on_delete: :delete_all
    has_many :likes, KnockoutApi.Like, on_delete: :delete_all
    field :number, :integer
    field :likes_count, :integer
    field :vod, :string

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(match_group_id number likes_count vod winner_id)a)
    |> validate_required(~w(match_group_id number winner_id)a)
    |> validate_url(:vod)
    |> validate_format(:vod, ~r/(youtube\.com\/embed)|(twitch.tv\/.*\/v\/)/, message: "must contain \"youtube.com/embed\" or \"twitch.tv\"")
    |> unique_constraint(:number, name: :matches_number_match_group_id_index)
    |> validate_number(:number, greater_than: 0)
  end

  defp validate_url(changeset, field, options \\ []) do
    validate_change changeset, field, fn _, url ->
      case url |> String.to_char_list |> :http_uri.parse do
        {:ok, _} -> []
        {:error, _} -> [{field, options[:message] || "is not a valid URL"}]
      end
    end
  end
end
