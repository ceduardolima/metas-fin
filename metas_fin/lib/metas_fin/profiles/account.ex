defmodule MetasFin.Profiles.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @schema_prefix  "perfil"
  schema "contas" do
    field :password, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, max: 100, message: "Email deve possuir no máximo 100 caracteres e no mínimo 10")
    |> validate_length(:password, max: 100, min: 6, message: "Senha deve possuir no máximo 100 caracteres e no mínimo 6")
    |> unique_constraint(:email)
  end
end
