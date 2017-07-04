defmodule UserTest do
  use ExUnit.Case
  doctest Users.User

  test "create user with valid email returns user" do
    {:ok, user} = Users.User.create("test@user.com", "test")
    assert user.email == "test@user.com"
    assert user.name == "test"
  end

  test "create user with invalid email returns error" do
    {:error, msg} =  Users.User.create("test@user", "test")
    assert msg == "Invalid email"
  end
end
