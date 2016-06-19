defmodule KnockoutApi.Tournament do
  use KnockoutApi.Web, :model
  import Ecto.Query

  schema "tournaments" do
    field :name, :string
    field :game_id, :string
    has_many :match_groups, KnockoutApi.MatchGroup

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def preload_all(query) do
    query |> KnockoutApi.Repo.preload([match_groups: [:team_one, :team_two, :matches]])
  end
end
