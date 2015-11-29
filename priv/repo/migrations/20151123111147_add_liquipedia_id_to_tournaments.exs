defmodule KnockoutApi.Repo.Migrations.AddLiquipediaIdToTournaments do
  use Ecto.Migration

  def change do
    alter table(:tournaments) do
      add :liquipedia_id, :string
    end
  end
end
