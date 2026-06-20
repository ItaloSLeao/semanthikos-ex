defmodule EventManager.Repo.Migrations.CreateCertificates do
  use Ecto.Migration

  def change do
    create table(:certificates) do
      add :certificate_type, :string, default: "participation", null: false
      add :generated_at, :utc_datetime, default: fragment("NOW()"), null: false
      add :certificate_number, :string, null: false
      add :pdf_data, :binary
      add :verified, :boolean, default: true, null: false
      add :hours, :integer
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:certificates, [:certificate_number])
    create unique_index(:certificates, [:user_id, :event_id, :certificate_type],
           name: :certificates_user_event_type_index)
    create index(:certificates, [:user_id])
    create index(:certificates, [:event_id])
  end
end