defmodule Stocksliveview.Assets do
  import Ecto.Query, warn: false
  alias Stocksliveview.Repo
  alias Stocksliveview.Assets.Asset

  def list_assets do
    Repo.all(Asset)
  end

  def get_stocks do
    query = from a in Asset, where: a.type == ^to_string('Stock')
    result = Repo.all(query)
  end

  def get_asset!(id), do: Repo.get!(Asset, id)

  def create_asset(attrs \\ %{}) do
    %Asset{}
    |> Asset.changeset(attrs)
    |> Repo.insert()
  end

  def update_asset(%Asset{} = asset, attrs) do
    asset
    |> Asset.changeset(attrs)
    |> Repo.update()
  end

  def delete_asset(%Asset{} = asset) do
    Repo.delete(asset)
  end

  def change_asset(%Asset{} = asset, attrs \\ %{}) do
    Asset.changeset(asset, attrs)
  end
end
