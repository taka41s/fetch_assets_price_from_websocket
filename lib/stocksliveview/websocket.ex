defmodule Stocksliveview.Websocket do
  use WebSockex
  require Logger

  def start_link(_), do: WebSockex.start_link("wss://ws.twelvedata.com/v1/quotes/price?apikey=e4513687adf14e1090772c0db481c38a", __MODULE__, nil)

  @impl true
  def handle_connect(_conn, state) do
    Logger.info("Connected...")
    send(self(), :subscribe)
    {:ok, state}
  end

  @impl true
  def handle_frame({:text, data}, state) do
    Logger.info("Received: #{inspect(data)}")

    {:ok, state}
  end

  @impl true
  def handle_info(:subscribe, state) do
    payload = %{"action" => "subscribe", "params" => %{"symbols" => "AAPL,BTC/USD"}}

    subscribe = Jason.encode!(payload)

    {:reply, {:text, subscribe}, state}
  end
end
