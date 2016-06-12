defmodule KnockoutApi.Repo.Migrations.CreateTournament do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :name, :string
      add :game_id, :string

      timestamps
    end
  end
end
