defmodule Events.Users.UseServiceTest do
  use ExUnit.Case, async: true
  alias Users.UserService

  setup do
    {:ok, serverPid} = Users.UserService.start_link
    {:ok, serverPid: serverPid}
  end

  test "Add new user happy path", context do
    {:ok, userId} = UserService.new_user(context[:serverPid], "TestUser", "test@simplex.com", "12345")

    assert 1 == userId
  end

  test "Get users", context do
    {:ok, userId1} = UserService.new_user(context[:serverPid], "TestUser", "test@simplex.com", "12345")
    {:ok, userId2} = UserService.new_user(context[:serverPid], "TestUser2", "test2@simplex.com", "12345")
    {:ok, users}  = UserService.get_users(context[:serverPid])
    assert Enum.find(users.users, fn(u) -> u.id == userId1 end) != nil
    assert Enum.find(users.users, fn(u) -> u.id == userId2 end) != nil
    assert Enum.find(users.users, fn(u) -> u.id == "4444" end) == nil
  end

  test "Create users generate incremental IDs", context do
    {:ok, user1} = UserService.new_user(context[:serverPid], "TestUser", "test@simplex.com", "12345")
    {:ok, user2} = UserService.new_user(context[:serverPid], "TestUser2", "test2@simplex.com", "12345")
    assert user2 > user1
  end

  test "Login doesn't log in unexisting user", context do
    {:error, "User not found"} = UserService.login(context[:serverPid], "test@simplex.com", "12345")
  end

  test "Login happy path", context do
    {:ok, userId} = UserService.new_user(context[:serverPid], "TestUser", "test@simplex.com", "12345")
    {:ok, loggedUser} = UserService.login(context[:serverPid], "test@simplex.com", "12345")
    assert loggedUser.id == userId
  end
end
