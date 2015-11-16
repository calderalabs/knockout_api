defmodule KnockoutApi.Repo.Migrations.CreateTournament do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :name, :string
      add :format, :string
      add :game_id, references(:games)

      timestamps
    end

    create unique_index(:tournaments, [:name])
  end
end
