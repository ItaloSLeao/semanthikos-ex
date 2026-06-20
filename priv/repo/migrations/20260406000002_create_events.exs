defmodule EventManager.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :title, :string, null: false
      add :description, :text, null: false
      add :date, :utc_datetime, null: false
      add :duration_minutes, :integer, default: 60, null: false
      add :location, :string, null: false
      add :max_seats, :integer, null: false
      add :status, :string, default: "draft", null: false
      add :image_url, :string
      add :is_online, :boolean, default: false, null: false
      add :online_url, :string
      add :tags, {:array, :string}, default: []
      add :speaker_id, references(:users, on_delete: :nothing), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:events, [:speaker_id])
    create index(:events, [:status])
    create index(:events, [:date])
    create index(:events, [:location])

    # Full-text search index for events
    execute """
    CREATE INDEX events_search_idx ON events
    USING GIN(to_tsvector('portuguese', title || ' ' || description))
    """
  end
end