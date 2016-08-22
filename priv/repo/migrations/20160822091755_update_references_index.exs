defmodule KnockoutApi.Repo.Migrations.UpdateReferencesIndex do
  use Ecto.Migration

  def change do
    drop_if_exists index(:match_groups, [:tournament_id])
    drop constraint(:match_groups, "match_groups_tournament_id_fkey")
    alter table(:match_groups) do
      modify :tournament_id, references(:tournaments, on_delete: :delete_all)
    end

    drop_if_exists index(:matches, [:match_group_id])
    drop constraint(:matches, "matches_match_group_id_fkey")
    alter table(:matches) do
      modify :match_group_id, references(:match_groups, on_delete: :delete_all)
    end

    drop_if_exists index(:followings, [:tournament_id])
    drop constraint(:followings, "followings_tournament_id_fkey")
    alter table(:followings) do
      modify :tournament_id, references(:tournaments, on_delete: :delete_all)
    end

    drop_if_exists index(:followings, [:user_id])
    drop constraint(:followings, "followings_user_id_fkey")
    alter table(:followings) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end

    drop_if_exists index(:likes, [:match_id])
    drop constraint(:likes, "likes_match_id_fkey")
    alter table(:likes) do
      modify :match_id, references(:matches, on_delete: :delete_all)
    end

    drop_if_exists index(:likes, [:user_id])
    drop constraint(:likes, "likes_user_id_fkey")
    alter table(:likes) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end

    drop_if_exists index(:spoilers, [:match_group_id])
    drop constraint(:spoilers, "spoilers_match_group_id_fkey")
    alter table(:spoilers) do
      modify :match_group_id, references(:match_groups, on_delete: :delete_all)
    end

    drop_if_exists index(:spoilers, [:match_id])
    drop constraint(:spoilers, "spoilers_match_id_fkey")
    alter table(:spoilers) do
      modify :match_id, references(:matches, on_delete: :delete_all)
    end

    drop_if_exists index(:spoilers, [:user_id])
    drop constraint(:spoilers, "spoilers_user_id_fkey")
    alter table(:spoilers) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end

    drop_if_exists index(:watchings, [:match_id])
    drop constraint(:watchings, "watchings_match_id_fkey")
    alter table(:watchings) do
      modify :match_id, references(:matches, on_delete: :delete_all)
    end

    drop_if_exists index(:watchings, [:user_id])
    drop constraint(:watchings, "watchings_user_id_fkey")
    alter table(:watchings) do
      modify :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
