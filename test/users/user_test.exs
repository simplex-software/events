defmodule UserTest do
  use ExUnit.Case
  doctest Users.User

  test "create user with valid email and password returns user and hashed password" do
    {:ok, user} = Users.User.new("fakename", "test@user.com", "12345", 1)
    assert user.email == "test@user.com"
    assert user.name == "fakename"
    assert user.hashed_password == "8CB2237D0679CA88DB6464EAC60DA96345513964"
    assert user.id == 1
  end

  test "create user with invalid email returns error" do
    {:error, msg} =  Users.User.new("test@user", "test", "12345", 1)
    assert msg == "Invalid email"
  end

  test "create user fails with null password" do
    {:error, msg} = Users.User.new("fakename", "test@user.com", nil, 1)
    assert msg == "Invalid email"
  end

  test "verify passwords returns true if password is correct" do
    assert Users.User.verify_password("12345", "8CB2237D0679CA88DB6464EAC60DA96345513964")
  end
end
