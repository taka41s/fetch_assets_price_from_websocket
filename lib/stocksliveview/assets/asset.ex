defmodule Stocksliveview.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :name, :string
    field :type, :string
    field :ticker, :string

    has_one :stocks, Stocksliveview.Assets.Stock
    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :type, :ticker])
    |> validate_required([:name, :type, :ticker])
  end
end
