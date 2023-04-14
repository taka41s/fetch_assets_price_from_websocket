defmodule Stocksliveview.Assets.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do


    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [])
    |> validate_required([])
  end
end
