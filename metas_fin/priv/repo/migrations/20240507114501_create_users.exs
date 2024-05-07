defmodule MetasFin.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:usuarios, primary_key: false, prefix: "perfil") do
      add :id, :binary_id, primary_key: true
      add :nome, :string, size: 80
      add :tb_conta_pk, references(:contas, on_delete: :delete_all, on_update: :update_all, type: :binary_id, prefix: "perfil")

      timestamps(type: :utc_datetime)
    end

    create unique_index(:usuarios, [:tb_conta_pk], prefix: "perfil")
  end
end
