defmodule KnockoutApi.Team do
  use KnockoutApi.Web, :model

  schema "teams" do
    field :full_name, :string
    field :short_name, :string
    field :country, :string
    field :logo, :map
    field :the_score_id, :integer

    timestamps
  end

  @required_fields ~w(full_name short_name the_score_id)
  @optional_fields ~w(country logo)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:the_score_id)
  end
end
