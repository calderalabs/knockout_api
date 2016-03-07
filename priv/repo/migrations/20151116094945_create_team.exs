defmodule KnockoutApi.Repo.Migrations.CreateTeam do
  use Ecto.Migration

  def change do
    create table(:teams) do
      add :full_name, :string
      add :short_name, :string
      add :country, :string
      add :logo, :json
      add :the_score_id, :integer

      timestamps
    end

    create unique_index(:teams, [:the_score_id])
  end
end
