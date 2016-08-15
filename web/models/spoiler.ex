defmodule KnockoutApi.Spoiler do
  use KnockoutApi.Web, :model

  schema "spoilers" do
    field :name, :string
    belongs_to :match_group, KnockoutApi.MatchGroup
    belongs_to :match, KnockoutApi.Match
    belongs_to :user, KnockoutApi.User

    timestamps
  end

  @required_fields ~w(name user_id)a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
