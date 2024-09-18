defmodule Blog.PostsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Blog.Posts` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    slug = :crypto.strong_rand_bytes(16) |> Base.url_encode64() |> binary_part(0, 16)

    {:ok, post} =
      attrs
      |> Enum.into(%{
        content: "some content",
        published_at: ~U[2024-09-04 13:12:00Z],
        slug: slug,
        status: "some status",
        title: "some title"
      })
      |> Blog.Posts.create_post()

    post
  end
end
