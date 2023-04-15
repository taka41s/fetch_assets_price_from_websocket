defmodule Stocksliveview.Repo.Migrations.ConvertIntegertoFloat do
  use Ecto.Migration

  def change do
    alter table(:assets) do
      modify :price, :float
    end
  end
end
