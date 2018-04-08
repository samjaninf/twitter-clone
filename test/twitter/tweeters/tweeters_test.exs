defmodule Twitter.TweetersTest do
  use Twitter.DataCase

  alias Twitter.Tweeters
  import Twitter.Factory
  alias Twitter.Tweeters.{User, Tweet}

  setup do
    user = insert(:user)
    tweet = insert(:tweet, user: user)
    {:ok, user: user, tweet: tweet}
  end

  describe "users" do
    test "list_users/0 returns all users" do
      assert length(Tweeters.list_users()) == 1
    end

    test "list_users/0 returns all users with preloaded tweets" do
      user = Tweeters.list_users() |> List.first
      assert length(user.tweets) == 1
    end

    test "get_user!/1 returns the user with given id", setup do
      user = setup[:user]
      user_first_name = Tweeters.get_user!(user.id).first_name
      user_id = Tweeters.get_user!(user.id).id
      assert user_first_name == user.first_name
      assert user_id == user.id
    end

    test "create_user/1 with valid data creates a user" do
      valid_user_params = params_for(:user)
      assert {:ok, %User{} = user} = Tweeters.create_user(valid_user_params)
      assert user.email == valid_user_params.email
      assert user.first_name == valid_user_params.first_name
      assert user.last_name == valid_user_params.last_name
      assert user.provider == valid_user_params.provider
      assert user.token == valid_user_params.token
    end

    test "create_user/1 with invalid data returns error changeset" do
      invalid_changeset = params_for(:user, token: "")
      assert {:error, %Ecto.Changeset{}} = Tweeters.create_user(invalid_changeset)
    end

    test "update_user/2 with valid data updates the user", setup do
      user = setup[:user]
      user_update_params = params_for(:user)
      assert {:ok, user} = Tweeters.update_user(user, user_update_params)
      assert %User{} = user
      assert user.email == user_update_params.email
      assert user.first_name == user_update_params.first_name
      assert user.last_name == user_update_params.last_name
      assert user.provider == user_update_params.provider
      assert user.token == user_update_params.token
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = insert(:user)
      invalid_user_update_params = params_for(:user, token: "")
      assert {:error, %Ecto.Changeset{}} = Tweeters.update_user(user, invalid_user_update_params)
      assert user.first_name == Tweeters.get_user!(user.id).first_name
    end

    test "delete_user/1 deletes the user" do
      user = insert(:user)
      assert {:ok, %User{}} = Tweeters.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Tweeters.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset", setup do
      user = setup[:user]
      assert %Ecto.Changeset{} = Tweeters.change_user(user)
    end
  end

  describe "tweets" do
    test "list_tweets/0 returns all tweets" do
      assert length(Tweeters.list_tweets()) == 1
    end

    test "get_tweet!/1 returns the tweet with given id", setup do
      tweet = setup[:tweet]
      assert Tweeters.get_tweet!(tweet.id).body == tweet.body
      assert Tweeters.get_tweet!(tweet.id).id == tweet.id
    end

    test "create_tweet/1 with valid data creates a tweet", setup do
      user = setup[:user]
      valid_tweet_params = params_for(:tweet)
      assert {:ok, %Tweet{} = tweet} = Tweeters.create_tweet(user, valid_tweet_params)
      assert tweet.body == valid_tweet_params.body
    end

    test "create_tweet/1 with invalid data returns error changeset", setup do
      user = setup[:user]
      invalid_tweet_params = params_for(:tweet, body: "")
      assert {:error, %Ecto.Changeset{}} = Tweeters.create_tweet(user, invalid_tweet_params)
    end

    test "update_tweet/2 with valid data updates the tweet" do
      tweet = insert(:tweet)
      valid_update_params = params_for(:tweet)
      assert {:ok, tweet} = Tweeters.update_tweet(tweet, valid_update_params)
      assert %Tweet{} = tweet
      assert tweet.body == valid_update_params.body
    end

    test "update_tweet/2 with invalid data returns error changeset", setup do
      tweet = insert(:tweet)
      invalid_update_params = params_for(:tweet, body: "")
      assert {:error, %Ecto.Changeset{}} = Tweeters.update_tweet(tweet, invalid_update_params)
      assert tweet.id == Tweeters.get_tweet!(tweet.id).id
    end

    test "delete_tweet/1 deletes the tweet" do
      tweet = insert(:tweet)
      assert {:ok, %Tweet{}} = Tweeters.delete_tweet(tweet)
      assert_raise Ecto.NoResultsError, fn -> Tweeters.get_tweet!(tweet.id) end
    end

    test "change_tweet/1 returns a tweet changeset" do
      tweet = insert(:tweet)
      assert %Ecto.Changeset{} = Tweeters.change_tweet(tweet)
    end
  end
end
