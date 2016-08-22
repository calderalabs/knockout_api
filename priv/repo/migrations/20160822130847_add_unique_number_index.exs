defmodule KnockoutApi.Repo.Migrations.AddUniqueNumberIndex do
  use Ecto.Migration

  def change do
    create unique_index(:matches, [:number, :match_group_id], name: :matches_number_match_group_id_index)
  end
end
