defmodule Stocksliveview.Assets do
  import Ecto.Query, warn: false
  alias Stocksliveview.Repo
  alias Stocksliveview.Asset

  def list_assets do
    Repo.all(Asset)
  end

  def list_by_type(type) do
    query = from a in Asset, where: a.type == ^to_string(type), select: a.ticker
    result = Repo.all(query)
  end

  def find_by_ticker(name) do
    Asset
    |> where([s], s.ticker == ^to_string(name))
    |> Repo.one()
  end

  def get_asset!(id), do: Repo.get!(Asset, id)

  def create_asset(attrs \\ %{}) do
    %Asset{}
    |> Asset.changeset(attrs)
    |> Repo.insert()
  end

  def update_asset(%Asset{} = asset, attrs) do
    IO.puts("Updating asset #{inspect(asset)} with params #{inspect(attrs)}")
    asset
    |> Asset.changeset(attrs)
    |> Repo.update()

    Ecto.PubSub.broadcast(Stocksliveview.Repo, "assets", asset)

    asset
  end
  # def update_asset(asset, params) do
  #   IO.puts("Updating asset #{inspect(asset)} with params #{inspect(params)}")
  #   case Repo.update(asset, params) do
  #     {:ok, _updated_asset} ->
  #       :ok
  #     {:error, changeset} ->
  #       IO.puts("Error updating asset: #{inspect(changeset)}")
  #       raise "Error updating asset: #{inspect(changeset)}"
  #   end

  def delete_asset(%Asset{} = asset) do
    Repo.delete(asset)
  end

  def change_asset(%Asset{} = asset, attrs \\ %{}) do
    Asset.changeset(asset, attrs)
  end
end
