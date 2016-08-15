defmodule KnockoutApi.Team do
  use KnockoutApi.Web, :model

  schema "teams" do
    field :full_name, :string
    field :short_name, :string
    field :logo_url, :string

    timestamps
  end

  @required_fields ~w(full_name short_name)a

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
