defmodule KnockoutApi.Repo.Migrations.AddDraftToTournament do
  use Ecto.Migration

  def change do
    alter table(:tournaments) do
      add :draft, :boolean, default: true
    end
  end
end
