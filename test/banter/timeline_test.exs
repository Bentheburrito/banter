defmodule Banter.TimelineTest do
  use Banter.DataCase

  alias Banter.Timeline

  describe "posts" do
    alias Banter.Timeline.Post

    import Banter.TimelineFixtures

    @invalid_attrs %{body: nil, down_votes: nil, title: nil, up_votes: nil, user: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Timeline.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Timeline.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{
        body: "some body",
        down_votes: "some down_votes",
        title: "some title",
        up_votes: "some up_votes",
        user: "some user"
      }

      assert {:ok, %Post{} = post} = Timeline.create_post(valid_attrs)
      assert post.body == "some body"
      assert post.down_votes == "some down_votes"
      assert post.title == "some title"
      assert post.up_votes == "some up_votes"
      assert post.user == "some user"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Timeline.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()

      update_attrs = %{
        body: "some updated body",
        down_votes: "some updated down_votes",
        title: "some updated title",
        up_votes: "some updated up_votes",
        user: "some updated user"
      }

      assert {:ok, %Post{} = post} = Timeline.update_post(post, update_attrs)
      assert post.body == "some updated body"
      assert post.down_votes == "some updated down_votes"
      assert post.title == "some updated title"
      assert post.up_votes == "some updated up_votes"
      assert post.user == "some updated user"
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Timeline.update_post(post, @invalid_attrs)
      assert post == Timeline.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Timeline.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Timeline.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Timeline.change_post(post)
    end
  end
end
