defmodule BlogWeb.Api.PostJSON do
  alias Blog.Posts.Post

  def index(%{posts: posts}) do
    %{data: for(post <- posts, do: data(post))}
  end

  def show(%{post: post}), do: %{data: data(post)}

  def data(%Post{} = post) do
    Map.take(post, [
      :id,
      :status,
      :title,
      :content,
      :slug,
      :published_at,
      :inserted_at,
      :updated_at
    ])
  end
end
