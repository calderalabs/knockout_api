defmodule KnockoutApi.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :name, :string
      add :logo_1x_url, :string
      add :logo_2x_url, :string

      timestamps
    end
  end
end
