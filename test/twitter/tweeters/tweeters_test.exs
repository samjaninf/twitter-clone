defmodule Twitter.TweetersTest do
  use Twitter.DataCase

  alias Twitter.Tweeters

  describe "users" do
    alias Twitter.Tweeters.User

    @valid_attrs %{email: "some email", first_name: "some first_name", last_name: "some last_name", provider: "some provider", token: "some token"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", provider: "some updated provider", token: "some updated token"}
    @invalid_attrs %{email: nil, first_name: nil, last_name: nil, provider: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tweeters.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Tweeters.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Tweeters.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Tweeters.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.last_name == "some last_name"
      assert user.provider == "some provider"
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tweeters.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Tweeters.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.last_name == "some updated last_name"
      assert user.provider == "some updated provider"
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Tweeters.update_user(user, @invalid_attrs)
      assert user == Tweeters.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Tweeters.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Tweeters.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Tweeters.change_user(user)
    end
  end

  describe "tweets" do
    alias Twitter.Tweeters.Tweet

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def tweet_fixture(attrs \\ %{}) do
      {:ok, tweet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Tweeters.create_tweet()

      tweet
    end

    test "list_tweets/0 returns all tweets" do
      tweet = tweet_fixture()
      assert Tweeters.list_tweets() == [tweet]
    end

    test "get_tweet!/1 returns the tweet with given id" do
      tweet = tweet_fixture()
      assert Tweeters.get_tweet!(tweet.id) == tweet
    end

    test "create_tweet/1 with valid data creates a tweet" do
      assert {:ok, %Tweet{} = tweet} = Tweeters.create_tweet(@valid_attrs)
      assert tweet.body == "some body"
    end

    test "create_tweet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tweeters.create_tweet(@invalid_attrs)
    end

    test "update_tweet/2 with valid data updates the tweet" do
      tweet = tweet_fixture()
      assert {:ok, tweet} = Tweeters.update_tweet(tweet, @update_attrs)
      assert %Tweet{} = tweet
      assert tweet.body == "some updated body"
    end

    test "update_tweet/2 with invalid data returns error changeset" do
      tweet = tweet_fixture()
      assert {:error, %Ecto.Changeset{}} = Tweeters.update_tweet(tweet, @invalid_attrs)
      assert tweet == Tweeters.get_tweet!(tweet.id)
    end

    test "delete_tweet/1 deletes the tweet" do
      tweet = tweet_fixture()
      assert {:ok, %Tweet{}} = Tweeters.delete_tweet(tweet)
      assert_raise Ecto.NoResultsError, fn -> Tweeters.get_tweet!(tweet.id) end
    end

    test "change_tweet/1 returns a tweet changeset" do
      tweet = tweet_fixture()
      assert %Ecto.Changeset{} = Tweeters.change_tweet(tweet)
    end
  end
end
