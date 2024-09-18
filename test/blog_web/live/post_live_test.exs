defmodule BlogWeb.PostLiveTest do
  use BlogWeb.ConnCase

  import Phoenix.LiveViewTest
  import Blog.PostsFixtures

  @create_attrs %{
    status: "some status",
    title: "some title",
    content: "some content",
    slug: "some slug",
    published_at: "2024-09-04T13:12:00Z"
  }
  @update_attrs %{
    status: "some updated status",
    title: "some updated title",
    content: "some updated content",
    slug: "some updated slug",
    published_at: "2024-09-05T13:12:00Z"
  }
  @invalid_attrs %{status: "", title: "", content: "", slug: "", published_at: ""}

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end

  describe "Index" do
    setup [:create_post, :register_and_log_in_user]

    test "lists all posts", %{conn: conn, post: post} do
      {:ok, _index_live, html} = live(conn, ~p"/admin/posts")

      assert html =~ "Listing Posts"
      assert html =~ post.status
    end

    test "saves new post", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/posts")

      assert index_live |> element("a", "New Post") |> render_click() =~
               "New Post"

      assert_patch(index_live, ~p"/admin/posts/new")

      assert index_live
             |> form("#post-form", post: @invalid_attrs)
             |> render_submit() =~ "can&#39;t be blank"

      index_live
      |> form("#post-form", post: @create_attrs)
      |> render_submit()

      assert_patch(index_live, ~p"/admin/posts")

      html = render(index_live)
      assert html =~ "Post created successfully"
      assert html =~ "some status"
    end

    test "updates post in listing", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/posts")

      assert index_live |> element("#posts-#{post.id} a", "Edit") |> render_click() =~
               "Edit Post"

      assert_patch(index_live, ~p"/admin/posts/#{post}/edit")

      assert index_live
             |> form("#post-form", post: @invalid_attrs)
             |> render_submit() =~ "can&#39;t be blank"

      index_live
      |> form("#post-form", post: @update_attrs)
      |> render_submit()

      assert_patch(index_live, ~p"/admin/posts")

      html = render(index_live)
      assert html =~ "Post updated successfully"
      assert html =~ "some updated status"
    end

    test "deletes post in listing", %{conn: conn, post: post} do
      {:ok, index_live, _html} = live(conn, ~p"/admin/posts")

      assert index_live |> element("#posts-#{post.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#posts-#{post.id}")
    end
  end

  describe "Show" do
    setup [:create_post, :register_and_log_in_user]

    test "displays post", %{conn: conn, post: post} do
      {:ok, _show_live, html} = live(conn, ~p"/admin/posts/#{post}")

      assert html =~ "Show Post"
      assert html =~ post.status
    end

    test "updates post within modal", %{conn: conn, post: post} do
      {:ok, show_live, _html} = live(conn, ~p"/admin/posts/#{post}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Post"

      assert_patch(show_live, ~p"/admin/posts/#{post}/show/edit")

      assert show_live
             |> form("#post-form", post: @invalid_attrs)
             |> render_submit() =~ "can&#39;t be blank"

      assert show_live
             |> form("#post-form", post: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/admin/posts/#{post}")

      html = render(show_live)
      assert html =~ "Post updated successfully"
      assert html =~ "some updated status"
    end
  end
end
