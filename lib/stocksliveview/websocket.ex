defmodule Stocksliveview.Websocket do
  alias Stocksliveview.Repo
  alias Stocksliveview.Asset
  use WebSockex
  require Logger
  require IO
  api_key = System.get_env("TWELVE_DATA_API_KEY")
  @url "wss://ws.twelvedata.com/v1/quotes/price?apikey=#{api_key}"

  def start_link(_), do: WebSockex.start_link(@url, __MODULE__, nil)

  @impl true
  def handle_connect(_conn, state) do
    send(self(), :subscribe)
    {:ok, state}
  end

  @impl true
  def handle_frame({:text, data}, state) do
    response = Jason.decode!(data)
    Logger.info(response)
    case %{price: response["price"], ticker: response["symbol"]} do
      %{ticker: ""} ->
        {:error, :ticker_invalid}

      %{price: price, ticker: ticker} ->
        asset = Stocksliveview.Assets.find_by_ticker(ticker)
        case asset do
          %Stocksliveview.Asset{} = asset ->
            asset
            |> Stocksliveview.Assets.update_asset(%{price: price})
          nil ->
            {:error, nil}
        end
      _ ->
        {:error, response}
    end

    {:ok, state}
  end

  @impl true
  def handle_info(:subscribe, state) do
    assets = Stocksliveview.Assets.fetch_all_assets
    payload = %{"action" => "subscribe", "params" => %{"symbols" => assets}}

    subscribe = Jason.encode!(payload)

    {:reply, {:text, subscribe}, state}
  end
end
