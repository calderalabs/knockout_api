defmodule KnockoutApi.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:followings) do
      add :tournament_id, references(:tournaments)
      add :user_id, references(:users)
      add :seen_at, :datetime

      timestamps
    end

    create index(:followings, [:user_id, :tournament_id], unique: true)
  end
end
