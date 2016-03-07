defmodule KnockoutApi.Repo.Migrations.CreateTournament do
  use Ecto.Migration

  def change do
    create table(:tournaments) do
      add :name, :string
      add :start_at, :datetime
      add :end_at, :datetime
      add :the_score_id, :integer

      timestamps
    end

    create unique_index(:tournaments, [:the_score_id])
  end
end
