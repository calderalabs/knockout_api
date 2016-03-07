defmodule KnockoutApi.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :winner_id, references(:teams)
      add :number, :integer
      add :match_group_id, references(:match_groups)
      add :the_score_id, :integer

      timestamps
    end

    create unique_index(:matches, [:the_score_id])
  end
end
