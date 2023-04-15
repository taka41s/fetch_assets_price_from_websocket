defmodule Stocksliveview.Repo.Migrations.ChangeNewFieldsToStocks do
  use Ecto.Migration

  def change do
    alter table(:assets) do
      remove :stock_id
    end

    alter table(:stocks) do
      add :asset_id, references(:assets)
    end
  end
end
