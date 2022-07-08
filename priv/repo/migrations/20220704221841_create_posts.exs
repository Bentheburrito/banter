defmodule Banter.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :text
      add :down_votes, :integer
      add :title, :string
      add :up_votes, :integer
      # add :sub_post_id, references(:posts), null: true
      add :user_id, references(:users)

      timestamps()
    end
  end
end
