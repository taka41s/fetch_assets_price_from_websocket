defmodule Stocksliveview.Repo.Migrations.Addforeignkeytoasset do
  use Ecto.Migration

  def change do
    alter table(:assets) do
      add :stock_id, references(:stocks)
    end
  end
end
