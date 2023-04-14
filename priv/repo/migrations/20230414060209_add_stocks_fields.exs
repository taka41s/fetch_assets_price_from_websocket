defmodule Stocksliveview.Repo.Migrations.AddStocksFields do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      add :ticker, :string
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
