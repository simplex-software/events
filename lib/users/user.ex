defmodule Users.User do
  defstruct id: nil, email: nil, name: nil, hashed_password: nil

  def new(name, email, password, id) do
    if is_valid(email, password) do
      {:ok, %Users.User{
                  name: name,
                  email: email,
                  hashed_password: hash_password(password),
                  id: id
                }}
    else
      {:error, "Invalid email"}
    end
  end

  def verify_password(password, hashed_password) do
    hash_password(password) == hashed_password
  end

  defp is_valid(email, password) do
    String.match?(email, ~r/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/) && password != nil
  end

  defp hash_password(password) do
    :crypto.hash(:sha, password) |> Base.encode16
  end
end
