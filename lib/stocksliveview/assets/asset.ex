defmodule Stocksliveview.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :name, :string
    field :type, :string
    field :ticker, :string
    field :price, :float
    field :open, :float
    field :close, :float
    field :adj_close, :float
    field :high, :float
    field :low, :float
    field :volume, :float

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :type, :ticker, :open, :close, :high, :low, :volume, :adj_close, :price])
    |> validate_required([:name, :type, :ticker])
  end
end
