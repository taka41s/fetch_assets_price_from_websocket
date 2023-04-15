defmodule Stocksliveview.Websocket do
  alias Stocksliveview.Repo
  alias Stocksliveview.Asset
  use WebSockex
  require Logger
  require IO
  @url "wss://ws.twelvedata.com/v1/quotes/price?apikey=e4513687adf14e1090772c0db481c38a"

  def start_link(_), do: WebSockex.start_link(@url, __MODULE__, nil)

  @impl true
  def handle_connect(_conn, state) do
    # Logger.info("Connected...")
    send(self(), :subscribe)
    {:ok, state}
  end

  @impl true
  def handle_frame({:text, data}, state) do
    response = Jason.decode!(data)

    case {:ok, %{price: response["price"], ticker: response["symbol"]}} do
      {:ok, %{ticker: ""}} ->
        Logger.warn("Empty ticker value received")
        :ok

      {:ok, %{price: price, ticker: ticker}} ->
        asset = Stocksliveview.Assets.find_by_ticker(ticker)
        case asset do
          %Stocksliveview.Asset{} = asset ->
            asset
            |> Stocksliveview.Assets.update_asset(%{price: price})
            :ok
          nil ->
            Logger.warn("No asset found for ticker: #{ticker}")
            :ok
        end
      _ ->
        Logger.warn("Invalid message received: #{inspect(response)}")
        :ok
    end

        # Stocksliveview.Assets.update_asset(asset, %{price: data[:price]})

    {:ok, state}
  end

  @impl true
  def handle_info(:subscribe, state) do
    payload = %{"action" => "subscribe", "params" => %{"symbols" => "BTC/USD"}}

    subscribe = Jason.encode!(payload)

    {:reply, {:text, subscribe}, state}
  end
end
