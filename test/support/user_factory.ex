defmodule Twitter.UserFactory do
  use ExMachina.Ecto, repo: Twitter.Repo
  alias Twitter.Tweeters.User

  def user_factory do
    %User{
      token: "ffnebyt73bich9",
      email: "batman@example.com",
      first_name: "Bruce",
      last_name: "Wayne",
      provider: "google"
    }
  end
end
