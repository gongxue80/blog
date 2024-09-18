defmodule Blog.Posts.Post do
  use Blog.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  schema "posts" do
    field :status, :string
    field :title, :string
    field :content, :string
    field :slug, :string
    field :published_at, :utc_datetime

    belongs_to :user, Blog.Accounts.User, foreign_key: :user_id

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :content, :slug, :published_at, :status])
    |> validate_required([:title, :content, :slug, :published_at, :status])
    |> unique_constraint(:slug)
  end
end
