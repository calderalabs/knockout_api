defmodule KnockoutApi.Like do
  alias KnockoutApi.Repo
  use KnockoutApi.Web, :model

  schema "likes" do
    belongs_to :match, KnockoutApi.Match
    belongs_to :user, KnockoutApi.User

    timestamps
  end

  @required_fields ~w(match_id user_id)
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

  def create(changeset) do
    changeset
    |> prepare_changes(fn changeset ->
      assoc(changeset.model, :match)
      |> changeset.repo.update_all(inc: [likes_count: 1])
      changeset
    end)
    |> Repo.insert
  end

  def destroy(like) do
    Ecto.Changeset.change(like)
    |> prepare_changes(fn changeset ->
      assoc(changeset.model, :match)
      |> changeset.repo.update_all(inc: [likes_count: -1])
      changeset
    end)
    |> Repo.delete
  end
end
