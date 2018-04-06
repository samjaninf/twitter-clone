defmodule Twitter.Factory do
  use ExMachina.Ecto, repo: Twitter.Repo
  alias Twitter.Tweeters.{User, Tweet}


  def user_factory do
    %User{
      token: Faker.Bitcoin.address,
      email: Faker.Internet.email,
      first_name: Faker.Name.first_name,
      last_name: Faker.Name.last_name,
      provider: "google"
    }
  end

  def tweet_factory do
    %Tweet{
      body: Faker.Lorem.ipsum,
      user_id: 1
    }
  end

end
