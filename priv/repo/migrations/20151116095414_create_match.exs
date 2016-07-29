defmodule KnockoutApi.Repo.Migrations.CreateMatch do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :winner_id, references(:teams)
      add :likes_count, :integer, null: false, default: 0
      add :number, :integer
      add :vod, :string
      add :match_group_id, references(:match_groups)

      timestamps
    end

    create unique_index(:matches, [:vod])
  end
end
