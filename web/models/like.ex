defmodule KnockoutApi.Like do
  use KnockoutApi.Web, :model

  schema "likes" do
    belongs_to :match, KnockoutApi.Match

    timestamps
  end

  @required_fields ~w(match_id)
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
end