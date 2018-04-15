defmodule TwitterWeb.TweetController do
  use TwitterWeb, :controller

  alias Twitter.Tweeters
  alias Twitter.Tweeters.Tweet

  plug Twitter.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_tweet_owner when action in [:edit, :update, :delete]


  def index(conn, _params, user) do
    tweets = Tweeters.list_tweets(user)
    render(conn, "index.html", tweets: tweets)
  end

  def new(conn, _params, user) do
    changeset = Tweeters.change_tweet(%Tweet{})

    render(conn, "new.html", changeset: changeset, user: user)
  end

  def create(conn, %{"tweet" => tweet_params}, user) do

    case Tweeters.create_tweet(user, tweet_params) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet created successfully.")
        |> redirect(to: user_tweet_path(conn, :show, user, tweet))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset, user: user)
    end
  end

  def show(conn, %{"id" => id}, user) do
    tweet = Tweeters.get_tweet!(id)
    render(conn, "show.html", tweet: tweet, user: user)
  end

  def edit(conn, %{"id" => id}, user) do
    tweet = Tweeters.get_tweet!(id)
    changeset = Tweeters.change_tweet(tweet)
    render(conn, "edit.html", tweet: tweet, changeset: changeset, user: user)
  end

  def update(conn, %{"id" => id, "tweet" => tweet_params}, user) do
    tweet = Tweeters.get_tweet!(id)

    case Tweeters.update_tweet(tweet, tweet_params) do
      {:ok, tweet} ->
        conn
        |> put_flash(:info, "Tweet updated successfully.")
        |> redirect(to: user_tweet_path(conn, :show, user, tweet))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", tweet: tweet, changeset: changeset, user: user)
    end
  end

  def delete(conn, %{"id" => id}, user) do
    tweet = Tweeters.get_tweet!(id)
    {:ok, _tweet} = Tweeters.delete_tweet(tweet)

    conn
    |> put_flash(:info, "Tweet deleted successfully.")
    |> redirect(to: user_tweet_path(conn, :index, user))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.user]
    apply(__MODULE__, action_name(conn), args)
  end

  defp check_tweet_owner(%{params: %{"id" => tweet_id}, assigns: %{user: user}} = conn, _params) do
    if Tweeters.get_tweet!(tweet_id).user_id == user.id do
      conn
    else
      conn
      |> put_flash(:error, "No Access.")
      |> redirect(to: user_tweet_path(conn, :index, user))
      |> halt()
    end
  end
end
