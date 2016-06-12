defmodule KnockoutApi.Repo.Migrations.CreateWatching do
  use Ecto.Migration

  def change do
    create table(:watchings) do
      add :match_id, references(:matches)

      timestamps
    end
  end
end
