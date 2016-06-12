defmodule KnockoutApi.Repo.Migrations.CreateSpoiler do
  use Ecto.Migration

  def change do
    create table(:spoilers) do
      add :name, :string
      add :match_group_id, references(:match_groups)
      add :match, references(:matches)

      timestamps
    end
  end
end
