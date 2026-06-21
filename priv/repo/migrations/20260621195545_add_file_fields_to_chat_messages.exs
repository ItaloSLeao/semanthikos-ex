defmodule EventManager.Repo.Migrations.AddFileFieldsToChatMessages do
  use Ecto.Migration

  def change do
    alter table(:chat_messages) do
      add :file_url, :string
      add :file_name, :string
      add :file_type, :string
    end
  end
end
