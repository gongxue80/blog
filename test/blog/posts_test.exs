defmodule Blog.PostsTest do
  use Blog.DataCase

  alias Blog.Posts

  describe "posts" do
    alias Blog.Posts.Post

    import Blog.PostsFixtures

    @invalid_attrs %{status: nil, title: nil, content: nil, slug: nil, published_at: nil}

    defp assert_post_fields(post1, post2) do
      assert post1.id == post2.id
      assert post1.status == post2.status
      assert post1.title == post2.title
      assert post1.content == post2.content
      assert post1.slug == post2.slug
      assert DateTime.truncate(post1.published_at, :second) == DateTime.truncate(post2.published_at, :second)
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      [returned_post] = Posts.list_posts()
      assert_post_fields(returned_post, post)
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      returned_post = Posts.get_post!(post.id)
      assert_post_fields(returned_post, post)
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{status: "some status", title: "some title", content: "some content", slug: "some slug", published_at: ~U[2024-09-04 13:12:00Z]}

      assert {:ok, %Post{} = post} = Posts.create_post(valid_attrs)
      assert post.status == "some status"
      assert post.title == "some title"
      assert post.content == "some content"
      assert post.slug == "some slug"
      assert post.published_at == ~U[2024-09-04 13:12:00Z]
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Posts.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      update_attrs = %{status: "some updated status", title: "some updated title", content: "some updated content", slug: "some updated slug", published_at: ~U[2024-09-05 13:12:00Z]}

      assert {:ok, %Post{} = post} = Posts.update_post(post, update_attrs)
      assert post.status == "some updated status"
      assert post.title == "some updated title"
      assert post.content == "some updated content"
      assert post.slug == "some updated slug"
      assert post.published_at == ~U[2024-09-05 13:12:00Z]
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Posts.update_post(post, @invalid_attrs)
      returned_post = Posts.get_post!(post.id)
      assert_post_fields(returned_post, post)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Posts.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Posts.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Posts.change_post(post)
    end
  end
end
