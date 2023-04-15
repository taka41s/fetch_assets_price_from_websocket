defmodule Stocksliveview.Repo.Migrations.AddNewFieldsToStocks do
  use Ecto.Migration

  def change do
    create table(:assets) do
      add :name, :string
      add :type, :string
      add :ticker, :string
      add :stock_id, references(:stocks)

      timestamps()
    end

    alter table(:stocks) do
      remove :ticker
    end
  end
end
