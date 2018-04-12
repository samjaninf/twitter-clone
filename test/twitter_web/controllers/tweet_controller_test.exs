defmodule TwitterWeb.TweetControllerTest do
  use TwitterWeb.ConnCase

  alias Twitter.Tweeters

  @create_attrs %{body: "some body"}
  @update_attrs %{body: "some updated body"}
  @invalid_attrs %{body: nil}

  def fixture(:tweet) do
    {:ok, tweet} = Tweeters.create_tweet(@create_attrs)
    tweet
  end

  describe "index" do
    test "lists all tweets", %{conn: conn} do
      conn = get conn, tweet_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Tweets"
    end
  end

  describe "new tweet" do
    test "renders form", %{conn: conn} do
      conn = get conn, tweet_path(conn, :new)
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "create tweet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, tweet_path(conn, :create), tweet: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == tweet_path(conn, :show, id)

      conn = get conn, tweet_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Tweet"
    end

    test "renders errors when data is invalid", %{conn: conn, invalid_tweet_params: invalid_tweet_params} do

      conn = post conn, tweet_path(conn, :create), tweet: invalid_tweet_params
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "edit tweet" do
    test "renders form for editing chosen tweet", %{conn: conn, tweet: tweet} do

      conn = get conn, tweet_path(conn, :edit, tweet)
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "update tweet" do
    test "redirects when data is valid", %{conn: conn, tweet: tweet, valid_tweet_params: valid_tweet_params} do

      conn = put conn, tweet_path(conn, :update, tweet), tweet: valid_tweet_params
      assert redirected_to(conn) == tweet_path(conn, :show, tweet)

      conn = get conn, tweet_path(conn, :show, tweet)
      assert html_response(conn, 200) =~ valid_tweet_params.body
    end

    test "renders errors when data is invalid", %{conn: conn, tweet: tweet, invalid_tweet_params: invalid_tweet_params} do

      conn = put conn, tweet_path(conn, :update, tweet), tweet: invalid_tweet_params
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "delete tweet" do
    test "deletes chosen tweet", %{conn: conn, tweet: tweet} do

      conn = delete conn, tweet_path(conn, :delete, tweet)
      assert redirected_to(conn) == tweet_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, tweet_path(conn, :show, tweet)
      end
    end
  end
end
