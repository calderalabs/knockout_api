defmodule KnockoutApi.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:followings) do
      add :tournament_id, references(:tournaments)

      timestamps
    end
  end
end
