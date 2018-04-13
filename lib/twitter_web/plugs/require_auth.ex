defmodule Twitter.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller
  alias TwitterWeb.Router.Helpers
  def init(_params) do
  end

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.user_tweet_path(conn, :index, conn.assigns.user))
      |> halt()
    end
  end
end
