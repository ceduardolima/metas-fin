defmodule MetasFin.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:contas, primary_key: false, prefix: "perfil") do
      add :id, :binary_id, primary_key: true
      add :email, :string, size: 100
      add :password, :string, size: 100

      timestamps(type: :utc_datetime)
    end

    create unique_index(:contas, [:email], prefix: "perfil")
  end
end
