defmodule KnockoutApi.Repo.Migrations.MakeGamesNameUnique do
  use Ecto.Migration

  def change do
    create unique_index(:games, [:name])
  end
end
