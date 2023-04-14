defmodule Stocksliveview.AssetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Stocksliveview.Assets` context.
  """

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{

      })
      |> Stocksliveview.Assets.create_stock()

    stock
  end
end
