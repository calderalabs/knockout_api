defmodule KnockoutApi.Spoiler do
  use KnockoutApi.Web, :model

  schema "spoilers" do
    field :name, :string
    belongs_to :match_group, KnockoutApi.MatchGroup
    belongs_to :match, KnockoutApi.Match
    belongs_to :user, KnockoutApi.User

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, ~w(name user_id match_group_id match_id)a)
    |> validate_required(~w(name user_id)a)
  end
end
