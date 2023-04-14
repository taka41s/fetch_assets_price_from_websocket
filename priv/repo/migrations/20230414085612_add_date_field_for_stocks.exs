defmodule Stocksliveview.Repo.Migrations.AddDateFieldForStocks do
  use Ecto.Migration

  def change do
    alter table(:stocks) do
      add :date, :date
    end
  end
end
