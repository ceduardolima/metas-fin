defmodule MetasFinWeb.Profile.AccountJSON do
  require Logger
  alias MetasFin.Profiles.Accounts.Account

  @doc """
  Renders a list of accounts.
  """
  def index(%{accounts: accounts}) do
    %{data: for(account <- accounts, do: data(account))}
  end

  @doc """
  Renders a single account.
  """
  def show(%{account: account}) do
    %{data: data(account)}
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      email: account.email,
      password: account.password
    }
  end

  def show_token(%{account: account, token: token}) do
    %{
      id: account.id,
      email: account.email,
      token: token
    }
  end

  def show_error(%{changeset: changeset}) do
    errors = build_changeset_error(changeset.errors)
    %{
      errors: errors
    }
  end

  defp build_changeset_error(errors) do
    Enum.reduce(errors, [], fn value, acc -> 
      {_, {msg, _}} = value
      [msg | acc]
    end)
  end
end
