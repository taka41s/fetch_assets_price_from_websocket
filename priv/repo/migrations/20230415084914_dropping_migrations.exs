defmodule Stocksliveview.Repo.Migrations.DroppingMigrations do
  use Ecto.Migration

  def change do
    drop table(:stocks)

    alter table(:assets) do
      add :price, :integer
      add :open, :float
      add :close, :float
      add :adj_close, :float
      add :high, :float
      add :low, :float
      add :volume, :float
    end
  end
end
