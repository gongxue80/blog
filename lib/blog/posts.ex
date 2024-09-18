defmodule Blog.Posts do
  @moduledoc """
  The Posts context.
  """

  import Ecto.Query, warn: false
  alias Blog.Repo

  alias Blog.Posts.Post

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post.

  Raises if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

  """
  def get_post!(id) do
    Repo.get!(Post, id)
  end

  @doc """
  Gets a single post by params.
  """
  @spec get_post_by!(params :: Keyword.t()) :: Post.t() | term()
  def get_post_by!(params) do
    Repo.get_by!(Post, params)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, ...}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, ...}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, ...}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns a data structure for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Todo{...}

  """
  def change_post(%Post{} = post, _attrs \\ %{}) do
    Post.changeset(post, %{})
  end
end
