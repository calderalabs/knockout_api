defmodule KnockoutApi.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :reference_id, references(:teams)

      timestamps
    end
  end
end
