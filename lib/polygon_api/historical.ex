defmodule PolygonApi do
  require Logger
  require HTTPoison

  def get_last_trade(ticker, date) do
    url = "https://api.polygon.io/v1/open-close/#{ticker}/#{date}?adjusted=true&apiKey=ogKoJqWTjDIkOTLdVpPsJv9pbkwjNuOv"

    case HTTPoison.get(url) do
      {:ok, %{body: body}} ->
        # parse the JSON response
        {:ok, last_trade} = Poison.decode(body)
        last_trade
      {:error, error} ->
        Logger.error("Error fetching last trade for #{ticker}: #{error}")
        {:error, error}
    end
  end
end
