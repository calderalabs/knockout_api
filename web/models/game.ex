defmodule KnockoutApi.Game do
  alias KnockoutApi.Game
  use KnockoutApi.Web, :model

  schema "games" do
    field :name, :string
    has_many :tournaments, KnockoutApi.Tournament

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def find_or_create_by_name(name) do
    case Repo.get_by(Game, name: name) do
      nil -> Repo.insert(Game.changeset(%Game{}, %{ name: name }))
      game -> {:ok, game}
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
    |> unique_constraint(:name)
  end
end
