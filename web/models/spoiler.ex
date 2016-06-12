defmodule KnockoutApi.Spoiler do
  use KnockoutApi.Web, :model

  schema "spoilers" do
    field :name, :string
    belongs_to :match_group, KnockoutApi.MatchGroup
    belongs_to :match, KnockoutApi.Match

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(match_group_id match_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
