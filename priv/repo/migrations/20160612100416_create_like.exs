defmodule KnockoutApi.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:likes) do
      add :match_id, references(:matches)

      timestamps
    end
  end
end
