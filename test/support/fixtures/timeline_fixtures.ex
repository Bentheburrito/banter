defmodule Banter.TimelineFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Banter.Timeline` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        down_votes: "some down_votes",
        title: "some title",
        up_votes: "some up_votes",
        user: "some user"
      })
      |> Banter.Timeline.create_post()

    post
  end
end
