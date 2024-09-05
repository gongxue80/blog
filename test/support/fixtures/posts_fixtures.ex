defmodule Blog.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published_at: ~U[2024-09-04 13:12:00Z],
        slug: "some slug",
        status: "some status",
        title: "some title"
      })
      |> Blog.Posts.create_post()

    post
  end
end
