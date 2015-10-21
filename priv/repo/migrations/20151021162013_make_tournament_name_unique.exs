defmodule KnockoutApi.Repo.Migrations.MakeTournamentNameUnique do
  use Ecto.Migration

  def change do
    create unique_index(:tournaments, [:name])
  end
end
