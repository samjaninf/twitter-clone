defmodule Twitter.UserFactory do
  use ExMachina.Ecto, repo: Twitter.Repo
  import Faker
  alias Twitter.Tweeters.User


  def user_factory do
    %User{
      token: Faker.Bitcoin.address,
      email: Faker.Internet.email,
      first_name: Faker.Name.first_name,
      last_name: Faker.Name.last_name,
      provider: "google"
    }
  end
end
