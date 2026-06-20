defmodule EventManager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :hashed_password, :string, null: false
      add :confirmed_at, :utc_datetime
      add :role, :string, default: "student", null: false
      add :name, :string, null: false
      add :course, :string
      add :department, :string
      add :bio, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
    create index(:users, [:role])
    create index(:users, [:course])
    create index(:users, [:department])
  end
end