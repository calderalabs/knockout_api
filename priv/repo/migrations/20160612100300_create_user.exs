defmodule KnockoutApi.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :auth0_id, :string
      add :email, :string

      timestamps
    end

    create index(:users, [:auth0_id])
  end
end
