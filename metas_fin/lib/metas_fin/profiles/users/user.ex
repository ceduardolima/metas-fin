defmodule MetasFin.Profiles.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @schema_prefix "perfil"
  schema "usuarios" do
    field :name, :string, [source: :nome]
    belongs_to :account, MetasFin.Profiles.Accounts.Account, [source: :tb_conta_pk]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :account_id])
    |> validate_required([:name, :account_id], message: "O campo 'name' não pode ser vazio")
    |> validate_length(:name, max: 80, message: "Nome deve possuir no máximo 80 caracteres")
    |> unique_constraint(:account_id)
  end
end
