defmodule Banter.Timeline.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Banter.Accounts.User

  schema "posts" do
    field :body, :string
    field :down_votes, :integer, default: 0
    field :title, :string
    field :up_votes, :integer, default: 0

    # I think we could add a `has_many super_posts, Post` later if we want to preload in the other direction.
    # has_one :sub_post, Post

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body, :down_votes, :title, :up_votes, :user_id])
    |> validate_required([:body, :title, :user_id])
    |> validate_length(:title, min: 2, max: 255)
    |> validate_length(:body, min: 280, max: 4000)
  end
end
