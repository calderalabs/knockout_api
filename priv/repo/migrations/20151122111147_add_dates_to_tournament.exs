defmodule KnockoutApi.Repo.Migrations.AddDatesToTournament do
  use Ecto.Migration

  def change do
    alter table(:tournaments) do
      add :start_at, :datetime
      add :end_at, :datetime
    end
  end
end
