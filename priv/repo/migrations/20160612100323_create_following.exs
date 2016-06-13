defmodule KnockoutApi.Repo.Migrations.CreateFollowing do
  use Ecto.Migration

  def change do
    create table(:followings) do
      add :tournament_id, references(:tournaments)
      add :user_id, references(:users)

      timestamps
    end
  end
end
