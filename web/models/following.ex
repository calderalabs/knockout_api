defmodule KnockoutApi.Following do
  use KnockoutApi.Web, :model

  schema "followings" do
    belongs_to :tournament, KnockoutApi.Tournament
    belongs_to :user, KnockoutApi.User

    timestamps
  end

  @required_fields ~w(tournament_id user_id)
  @optional_fields ~w()

  def for_user(user) do
    case user do
      nil -> []
      user ->
        KnockoutApi.Repo.all(from f in KnockoutApi.Following,
          where: f.user_id == ^(user.id)
        )
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
