defmodule KnockoutApi.Spoiler do
  alias KnockoutApi.Repo
  use KnockoutApi.Web, :model

  schema "spoilers" do
    field :name, :string
    belongs_to :match_group, KnockoutApi.MatchGroup
    belongs_to :match, KnockoutApi.Match
    belongs_to :user, KnockoutApi.User

    timestamps
  end

  @required_fields ~w(name user_id)
  @optional_fields ~w(match_group_id match_id)

  def for_user(query, user) do
    case user do
      nil -> []
      user -> Repo.all(from s in query, where: s.user_id == ^(user.id))
    end
  end

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
