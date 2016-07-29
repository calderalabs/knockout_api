defmodule KnockoutApi.Repo.Migrations.CreateTournament do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :name, :string
      add :game_id, :string
      add :current_stage, :string

      timestamps
    end
  end
end
