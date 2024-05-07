defmodule MetasFin.Profiles.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MetasFin.Profiles.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MetasFin.Profiles.Users.create_user()

    user
  end
end
