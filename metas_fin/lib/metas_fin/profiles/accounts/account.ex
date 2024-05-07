defmodule MetasFin.Profiles.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @schema_prefix  "perfil"
  schema "contas" do
    field :password, :string
    field :email, :string
    has_one :user, MetasFin.Profiles.Users.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password], message: "Campos email e password são obrigatórios")
    |> validate_format(:email, ~r/@/, message: "Formato do email inválido")
    |> validate_length(:email, max: 100, message: "Email deve possuir no máximo 100 caracteres e no mínimo 10")
    |> validate_length(:password, max: 100, min: 6, message: "Senha deve possuir no máximo 100 caracteres e no mínimo 6")
    |> put_hash_password()
    |> unique_constraint(:email, message: "O email já existe")
  end

  defp put_hash_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do 
    change(changeset, password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_hash_password(changeset), do: changeset
end
