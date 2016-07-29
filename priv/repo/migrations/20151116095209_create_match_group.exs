defmodule KnockoutApi.Repo.Migrations.CreateMatchGroup do
  use Ecto.Migration

  def change do
    create table(:match_groups) do
      add :started_at, :datetime
      add :tournament_id, references(:tournaments)
      add :team_one_id, references(:teams)
      add :team_two_id, references(:teams)
      add :best_of, :integer
      add :stage, :string

      timestamps
    end
  end
end
