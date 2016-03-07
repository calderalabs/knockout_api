defmodule KnockoutApi.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :full_name, :string
      add :short_name, :string
      add :country, :string
      add :logo, :json

      timestamps
    end
  end
end
