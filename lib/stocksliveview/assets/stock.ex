defmodule Stocksliveview.Assets.Stock do
  use Ecto.Schema
  import Ecto.Changeset

  schema "stocks" do
    field :price, :integer
    field :open, :float
    field :close, :float
    field :adj_close, :float
    field :high, :float
    field :low, :float
    field :volume, :float
    field :date, :date
    belongs_to :asset, Asset

    timestamps()
  end

  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, [:ticker, :open, :close, :high, :low, :volume, :adj_close, :price, :date])
    |> validate_required([:ticker, :open, :close, :high, :low, :volume, :price, :date])
  end
end
