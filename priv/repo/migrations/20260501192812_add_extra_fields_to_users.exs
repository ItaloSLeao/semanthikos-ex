defmodule EventManager.Repo.Migrations.AddExtraFieldsToUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :cpf, :string
      add :birth_date, :date
      add :registration_id, :string
    end
  end
end
