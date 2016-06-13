defmodule KnockoutApi.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :match_id, references(:matches)
      add :user_id, references(:users)

      timestamps
    end
  end
end
