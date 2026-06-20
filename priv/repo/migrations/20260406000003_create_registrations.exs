defmodule EventManager.Repo.Migrations.CreateRegistrations do
  use Ecto.Migration

  def change do
    create table(:registrations) do
      add :registered_at, :utc_datetime, default: fragment("NOW()"), null: false
      add :attended, :boolean, default: false, null: false
      add :attendance_marked_at, :utc_datetime
      add :notes, :text
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:registrations, [:user_id, :event_id], name: :registrations_user_event_index)
    create index(:registrations, [:user_id])
    create index(:registrations, [:event_id])
    create index(:registrations, [:attended])
  end
end