defmodule KnockoutApi.Repo.Migrations.CreateSpoiler do
  use Ecto.Migration

  def change do
    create table(:spoilers) do
      add :name, :string
      add :match_group_id, references(:match_groups)
      add :match_id, references(:matches)
      add :user_id, references(:users)

      timestamps
    end

    create index(:spoilers, [:user_id, :match_group_id, :match_id], unique: true)
  end
end
