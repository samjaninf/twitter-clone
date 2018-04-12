defmodule TwitterWeb.UserControllerTest do
  use TwitterWeb.ConnCase

  alias Twitter.Tweeters
  import Twitter.Factory

  setup do
    user = insert(:user)
    valid_user_params = params_for(:user)
    invalid_user_params = params_for(:user, email: "")
    {:ok, user: user, valid_user_params: valid_user_params, invalid_user_params: invalid_user_params}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get conn, user_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Users"
    end
  end

  describe "new user" do
    test "renders form", %{conn: conn} do
      conn = get conn, user_path(conn, :new)
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "create user" do
    test "redirects to show when data is valid", %{conn: conn, valid_user_params: valid_user_params} do

      conn = post conn, user_path(conn, :create), user: valid_user_params

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_path(conn, :show, id)

      conn = get conn, user_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show User"
    end

    test "renders errors when data is invalid", %{conn: conn, invalid_user_params: invalid_user_params} do

      conn = post conn, user_path(conn, :create), user: invalid_user_params
      assert html_response(conn, 200) =~ "New User"
    end
  end

  describe "edit user" do
    test "renders form for editing chosen user", %{conn: conn, user: user} do

      conn = get conn, user_path(conn, :edit, user)
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "update user" do
    test "redirects when data is valid", %{conn: conn, user: user, valid_user_params: valid_user_params} do

      conn = put conn, user_path(conn, :update, user), user: valid_user_params
      assert redirected_to(conn) == user_path(conn, :show, user)

      conn = get conn, user_path(conn, :show, user)
      assert html_response(conn, 200) =~ valid_user_params.email
    end

    test "renders errors when data is invalid", %{conn: conn, user: user, invalid_user_params: invalid_user_params} do

      conn = put conn, user_path(conn, :update, user), user: invalid_user_params
      assert html_response(conn, 200) =~ "Edit User"
    end
  end

  describe "delete user" do
    test "deletes chosen user", %{conn: conn, user: user} do

      conn = delete conn, user_path(conn, :delete, user)
      assert redirected_to(conn) == user_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, user_path(conn, :show, user)
      end
    end
  end
end
