defmodule BlogWeb.Api.PostController do
  use BlogWeb, :controller

  alias Blog.Posts

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def show(conn, %{"slug" => slug}) do
    IO.inspect(slug)
    post = Posts.get_post_by!(slug: slug)
    render(conn, "show.json", post: post)
  end
end
