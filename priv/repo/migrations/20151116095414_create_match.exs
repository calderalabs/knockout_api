defmodule KnockoutApi.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :team_one_id, references(:teams)
      add :team_two_id, references(:teams)
      add :winner_id, references(:teams)
      add :match_group_id, references(:match_groups)

      timestamps
    end
  end
end
