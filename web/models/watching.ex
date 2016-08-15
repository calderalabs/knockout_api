defmodule KnockoutApi.Watching do
  use KnockoutApi.Web, :model

  schema "watchings" do
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
end
