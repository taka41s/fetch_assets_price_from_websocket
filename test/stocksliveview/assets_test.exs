defmodule Stocksliveview.AssetsTest do
  use Stocksliveview.DataCase

  alias Stocksliveview.Assets

  describe "stocks" do
    alias Stocksliveview.Assets.Stock

    import Stocksliveview.AssetsFixtures

    @invalid_attrs %{}

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Assets.list_stocks() == [stock]
    end

    test "get_stock!/1 returns the stock with given id" do
      stock = stock_fixture()
      assert Assets.get_stock!(stock.id) == stock
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{}

      assert {:ok, %Stock{} = stock} = Assets.create_stock(valid_attrs)
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Assets.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{}

      assert {:ok, %Stock{} = stock} = Assets.update_stock(stock, update_attrs)
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Assets.update_stock(stock, @invalid_attrs)
      assert stock == Assets.get_stock!(stock.id)
    end

    test "delete_stock/1 deletes the stock" do
      stock = stock_fixture()
      assert {:ok, %Stock{}} = Assets.delete_stock(stock)
      assert_raise Ecto.NoResultsError, fn -> Assets.get_stock!(stock.id) end
    end

    test "change_stock/1 returns a stock changeset" do
      stock = stock_fixture()
      assert %Ecto.Changeset{} = Assets.change_stock(stock)
    end
  end
end
