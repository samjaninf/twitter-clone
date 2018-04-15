defmodule TwitterWeb.TweetControllerTest do
  use TwitterWeb.ConnCase

  import Twitter.Factory

  setup do
    user = insert(:user)
    tweet = insert(:tweet, user: user)
    valid_tweet_params = params_for(:tweet)
    invalid_tweet_params = params_for(:tweet, body: "")
    conn = assign(build_conn(), :user, user)

    {:ok, %{conn: conn, user: user, tweet: tweet,
      valid_tweet_params: valid_tweet_params,
      invalid_tweet_params: invalid_tweet_params}
    }

  end

  describe "index" do
    test "lists all tweets", %{conn: conn} do

      conn = get conn, user_tweet_path(conn, :index, conn.assigns[:user])
      assert html_response(conn, 200) =~ "Listing Tweets"
    end
  end

  describe "new tweet" do
    test "renders form", %{conn: conn, user: user} do

      conn = get conn, user_tweet_path(conn, :new, user)
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "create tweet" do
    test "redirects to show when data is valid", %{conn: conn, user: user, valid_tweet_params: valid_tweet_params} do
      conn = post conn, user_tweet_path(conn, :create, user), tweet: valid_tweet_params

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_tweet_path(conn, :show, user, id)

      # conn = get conn, user_tweet_path(conn, :show, user, id)
      # assert html_response(conn, 200) =~ "Show Tweet"
    end

    test "renders errors when data is invalid", %{conn: conn, invalid_tweet_params: invalid_tweet_params} do

      conn = post conn, user_tweet_path(conn, :create, conn.assigns.user), tweet: invalid_tweet_params
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "edit tweet" do
    test "renders form for editing chosen tweet", %{conn: conn, tweet: tweet} do

      conn = get conn, user_tweet_path(conn, :edit, conn.assigns[:user], tweet)
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "update tweet" do
    test "redirects when data is valid", %{conn: conn, user: user, tweet: tweet, valid_tweet_params: valid_tweet_params} do

      conn = put conn, user_tweet_path(conn, :update, user, tweet), tweet: valid_tweet_params
      assert redirected_to(conn) == user_tweet_path(conn, :show, user, tweet)

      # conn = get conn, user_tweet_path(conn, :show, user, tweet)
      # assert html_response(conn, 200) =~ valid_tweet_params.body
    end

    test "renders errors when data is invalid", %{conn: conn, user: user, tweet: tweet, invalid_tweet_params: invalid_tweet_params} do

      conn = put conn, user_tweet_path(conn, :update, user, tweet), tweet: invalid_tweet_params
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "delete tweet" do
    test "deletes chosen tweet", %{conn: conn, user: user, tweet: tweet} do

      conn = delete conn, user_tweet_path(conn, :delete, user, tweet)
      assert redirected_to(conn) == user_tweet_path(conn, :index, conn.assigns[:user])
      assert_error_sent 404, fn ->
        get conn, user_tweet_path(conn, :show, user, tweet)
      end
    end
  end
end
