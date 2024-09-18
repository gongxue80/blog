defmodule BlogWeb.PageController do
  use BlogWeb, :controller

  def angular(conn, _params) do
    conn
    |> put_resp_content_type("text/html")
    |> send_file(200, "priv/static/frontend/browser/index.html")
  end
end
