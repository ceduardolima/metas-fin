defmodule MetasFin.ProfilesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MetasFin.Profiles` context.
  """

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        email: "some email",
        password: "some password"
      })
      |> MetasFin.Profiles.create_account()

    account
  end
end
