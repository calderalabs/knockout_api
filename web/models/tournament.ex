defmodule KnockoutApi.Tournament do
  use KnockoutApi.Web, :model

  schema "tournaments" do
    field :name, :string
    field :start_at, Ecto.DateTime
    field :end_at, Ecto.DateTime

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(start_at end_at)

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
