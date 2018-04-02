defmodule TwitterWeb.AuthController do
  use TwitterWeb, :controller
  plug Ueberauth

  def new(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    user_params = %{token: auth.credentials.token, first_name: auth.info.first_name, last_name: auth.info.last_name, email: auth.info.email, provider: "google"}
    changeset = User.changeset(%User{}, user_params)

    create(conn, changeset)
  end
end
