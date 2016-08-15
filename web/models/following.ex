defmodule KnockoutApi.Following do
  alias KnockoutApi.{Repo, Match, Watching}
  use KnockoutApi.Web, :model

  schema "followings" do
    belongs_to :tournament, KnockoutApi.Tournament
    belongs_to :user, KnockoutApi.User
    field :seen_at, Timex.Ecto.DateTime

    timestamps
  end

  @required_fields ~w(tournament_id user_id seen_at)a

  def new_matches_count(following) do
    case following.seen_at do
      nil -> 0
      seen_at -> Repo.all(from m in Match,
        select: count(m.id),
        where: m.inserted_at > ^(seen_at),
          left_join: w in Watching,
          on: m.id == w.match_id,
          where: is_nil(w.match_id)
      )
    end
  end

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
