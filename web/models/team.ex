defmodule KnockoutApi.Team do
  use KnockoutApi.Web, :model

  schema "teams" do
    field :name, :string
    field :logo_1x_url, :string
    field :logo_2x_url, :string

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w(logo_1x_url logo_2x_url)

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
