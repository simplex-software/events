defmodule Users.User do
  defstruct email: nil, name: nil

  def create(email, name) do
    if String.match?(email, ~r/(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)/) do
      {:ok, %Users.User{email: email, name: name}}
    else
      {:error, "Invalid email"}
    end
  end
end
