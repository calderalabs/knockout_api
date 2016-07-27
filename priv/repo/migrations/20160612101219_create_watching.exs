defmodule KnockoutApi.Repo.Migrations.CreateWatching do
  use Ecto.Migration

  def change do
    create table(:watchings) do
      add :match_id, references(:matches)
      add :user_id, references(:users)

      timestamps
    end

    create index(:watchings, [:user_id, :match_id], unique: true)
  end
end
