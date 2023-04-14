defmodule Stocksliveview.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks) do

      timestamps()
    end
  end
end
