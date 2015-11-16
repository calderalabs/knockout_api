defmodule KnockoutApi.Repo.Migrations.CreatePlayer do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :name, :string
      add :team_id, references(:teams)
      add :reference_id, references(:players)

      timestamps
    end
  end
end
