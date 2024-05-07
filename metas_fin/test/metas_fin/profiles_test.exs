defmodule MetasFin.ProfilesTest do
  use MetasFin.DataCase

  alias MetasFin.Profiles

  describe "accounts" do
    alias MetasFin.Profiles.Account

    import MetasFin.ProfilesFixtures

    @invalid_attrs %{password: nil, email: nil}

    test "list_accounts/0 returns all accounts" do
      account = account_fixture()
      assert Profiles.list_accounts() == [account]
    end

    test "get_account!/1 returns the account with given id" do
      account = account_fixture()
      assert Profiles.get_account!(account.id) == account
    end

    test "create_account/1 with valid data creates a account" do
      valid_attrs = %{password: "some password", email: "some email"}

      assert {:ok, %Account{} = account} = Profiles.create_account(valid_attrs)
      assert account.password == "some password"
      assert account.email == "some email"
    end

    test "create_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Profiles.create_account(@invalid_attrs)
    end

    test "update_account/2 with valid data updates the account" do
      account = account_fixture()
      update_attrs = %{password: "some updated password", email: "some updated email"}

      assert {:ok, %Account{} = account} = Profiles.update_account(account, update_attrs)
      assert account.password == "some updated password"
      assert account.email == "some updated email"
    end

    test "update_account/2 with invalid data returns error changeset" do
      account = account_fixture()
      assert {:error, %Ecto.Changeset{}} = Profiles.update_account(account, @invalid_attrs)
      assert account == Profiles.get_account!(account.id)
    end

    test "delete_account/1 deletes the account" do
      account = account_fixture()
      assert {:ok, %Account{}} = Profiles.delete_account(account)
      assert_raise Ecto.NoResultsError, fn -> Profiles.get_account!(account.id) end
    end

    test "change_account/1 returns a account changeset" do
      account = account_fixture()
      assert %Ecto.Changeset{} = Profiles.change_account(account)
    end
  end
end
