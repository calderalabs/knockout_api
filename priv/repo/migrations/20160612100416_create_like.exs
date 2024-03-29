defmodule KnockoutApi.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :match_id, references(:matches)
      add :user_id, references(:users)

      timestamps
    end

    create index(:likes, [:user_id, :match_id], unique: true)
  end
end
