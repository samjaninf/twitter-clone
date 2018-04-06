defmodule Twitter.Tweeters.Tweet do
  use Ecto.Schema
  import Ecto.Changeset
  alias Twitter.Tweeters.User


  schema "tweets" do
    field :body, :string
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
