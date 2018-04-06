defmodule Twitter.Tweeters.Tweet do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tweets" do
    field :body, :string

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
