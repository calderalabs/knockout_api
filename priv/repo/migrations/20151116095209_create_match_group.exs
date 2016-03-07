defmodule KnockoutApi.Repo.Migrations.CreateMatchGroup do
  use Ecto.Migration

  def change do
    create table(:match_groups) do
      add :start_at, :datetime
      add :end_at, :datetime
      add :tournament_id, references(:tournaments)
      add :team_one_id, references(:teams)
      add :team_two_id, references(:teams)
      add :best_of, :integer
      add :team_one_score, :integer
      add :team_two_score, :integer
      add :winner_id, references(:teams)
      add :vods, :json
      add :the_score_id, :integer

      timestamps
    end

    create unique_index(:match_groups, [:the_score_id])
  end
end
