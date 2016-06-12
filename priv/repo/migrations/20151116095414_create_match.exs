defmodule KnockoutApi.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :winner_id, references(:teams)
      add :like_count, :integer
      add :number, :integer
      add :vod, :json
      add :match_group_id, references(:match_groups)

      timestamps
    end
  end
end
