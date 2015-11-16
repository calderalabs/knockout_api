defmodule KnockoutApi.Player do
  use KnockoutApi.Web, :model

  schema "players" do
    field :name, :string
    belongs_to :team, KnockoutApi.Team
    belongs_to :reference, KnockoutApi.Player

    timestamps
  end

  @required_fields ~w(name team_id reference_id)
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
