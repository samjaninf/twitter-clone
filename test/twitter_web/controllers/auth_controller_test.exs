defmodule TwitterWeb.AuthControllerTest do
  use TwitterWeb.ConnCase
  alias Twitter.{Repo, User}
  import Twitter.UserFactory

  @ueberauth_auth %{credentials: %{token: "fdsnoafhnoofh08h38h"},
                   info: %{email: "batman@example.com", first_name: "Bruce", last_name: "Wayne"},
                   provider: :google}

  test "redirects user to Google for authentication", %{conn: conn} do
    conn = get conn, "/auth/google?scope=email%20profile"
    assert redirected_to(conn, 302)
  end

  test "creates user from Google information", %{conn: conn} do
    conn = conn
    |> assign(:ueberauth_auth, @ueberauth_auth)
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
