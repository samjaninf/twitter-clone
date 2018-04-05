defmodule TwitterWeb.AuthControllerTest do
  use TwitterWeb.ConnCase
  alias Twitter.Tweeters.User
  alias Twitter.Repo
  import Twitter.Factory


  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google?scope=email%20profile"

    assert redirected_to(conn, 302)
  end

  test "creates user from Google information", %{conn: conn} do
    user = insert(:user)
    ueberauth_auth = %{credentials: %{token: user.token},
                      info: %{email: user.email, first_name: user.first_name, last_name: user.last_name},
                      provider: :google}

    conn = conn
    |> assign(:ueberauth_auth, ueberauth_auth)
    |> get("/auth/google/callback")

    users = User |> Repo.all

    assert Enum.count(users) == 1
    assert get_flash(conn, :info) == "Thank you for signing in!"
  end

  test "signs out user", %{conn: conn} do
    user = insert(:user)

    conn = conn
    |> assign(:user, user)
    |> get("/auth/signout")
    |> get("/")

    assert conn.assigns.user == nil
  end
end
