defmodule MetasFin.Profiles.Guardian do
  use Guardian, otp_app: :metas_fin
  alias MetasFin.Profiles.Accounts

  def subject_for_token(%{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    user = Accounts.get_account!(id)
    {:ok, user}
  rescue
    Ecto.NoResultsError -> {:error, :resource_not_found}
  end

  def authenticate(email, password) do
    case Accounts.get_account_by_email(email) do
      nil ->
        {:error, :unauthorized}

      account ->
        case validate_password(password, account.password) do
          false ->
            {:error, :unauthorized}

          true ->
            create_token(account, :access)
        end
    end
  end

  defp validate_password(password, hash_password), do: Bcrypt.verify_pass(password, hash_password)

  defp create_token(account, type) do
    {:ok, token, _claims} = encode_and_sign(account, %{}, token_opts(type))
    {:ok, account, token}
  end

  defp token_opts(type) do
    case type do
      :access -> [token_type: "access", ttl: {2, :hour}]
      :reset -> [token_type: "reset", ttl: {2, :hour}]
    end
  end
end
