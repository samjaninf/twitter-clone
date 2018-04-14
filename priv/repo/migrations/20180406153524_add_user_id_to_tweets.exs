defmodule Twitter.Repo.Migrations.AddUserIdToTweets do
  use Ecto.Migration

  def change do
    alter table(:tweets) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
    create unique_index(:users, [:email], comment: "Unique Index User Email" )
    create index(:tweets, [:user_id], comment: "Index User ID")
  end
end
