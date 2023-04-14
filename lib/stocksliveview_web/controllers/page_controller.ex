defmodule StocksliveviewWeb.PageController do
  use StocksliveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
