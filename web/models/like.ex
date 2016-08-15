defmodule KnockoutApi.Like do
  alias KnockoutApi.Repo
  use KnockoutApi.Web, :model

  schema "likes" do
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
    |> cast(params, ~w(match_id user_id)a)
    |> validate_required(~w(match_id user_id)a)
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
