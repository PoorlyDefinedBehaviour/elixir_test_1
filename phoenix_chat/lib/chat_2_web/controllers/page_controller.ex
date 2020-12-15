defmodule Chat2Web.PageController do
  use Chat2Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
