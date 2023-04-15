defmodule Stocksliveview.Repo.Migrations.FixingMigrations do
  use Ecto.Migration

  def change do
    alter table(:assets) do
      remove :stock_id
    end
  end
end
