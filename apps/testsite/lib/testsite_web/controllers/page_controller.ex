defmodule TestsiteWeb.PageController do
  use TestsiteWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
