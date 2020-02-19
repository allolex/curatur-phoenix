defmodule CuraturWeb.PageController do
  use CuraturWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
