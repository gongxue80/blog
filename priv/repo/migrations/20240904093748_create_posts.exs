defmodule Blog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :content, :text
      add :slug, :string
      add :published_at, :utc_datetime
      add :status, :string
      add :user_id, references(:users, type: :uuid, on_delete: :nothing)

      timestamps(type: :utc_datetime_usec)
    end

    create unique_index(:posts, [:slug])
    create index(:posts, [:user_id])
  end
end
