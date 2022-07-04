defmodule BanterWeb.PageController do
  use BanterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
