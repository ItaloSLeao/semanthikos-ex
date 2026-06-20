defmodule EventManager.Repo.Migrations.CreateChatMessages do
  use Ecto.Migration

  def change do
    create table(:chat_messages) do
      add :message, :text, null: false
      add :sent_at, :utc_datetime, default: fragment("NOW()"), null: false
      add :is_question, :boolean, default: false, null: false
      add :is_answered, :boolean, default: false, null: false
      add :parent_message_id, :id
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:chat_messages, [:user_id])
    create index(:chat_messages, [:event_id])
    create index(:chat_messages, [:sent_at])
    create index(:chat_messages, [:is_question])
    create index(:chat_messages, [:parent_message_id])
  end
end