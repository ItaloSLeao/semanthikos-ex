defmodule EventManager.Repo.Migrations.AddStatusToRegistrations do
  use Ecto.Migration

  def change do
    alter table(:registrations) do
      add :status, :string, default: "confirmed", null: false
    end
  end
end
