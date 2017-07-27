defmodule Users.UserService do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

  def init(pid) do
    {:ok, pid}
  end

  def new_user(pid, name, email, password) do
    GenServer.call(pid, {:new_user, name, email, password})
  end

  def get_users(pid) do
    GenServer.call(pid, {:get_users})
  end

  #CALLBACKS

  def handle_call({:new_user, name, email, password}, _from, users) do
    {:ok, user} = Users.User.new(name, email, password, next_user_id(users))
    users = [user | users]
    {:reply, {:ok, user.id}, users}
  end

  def handle_call({:get_users}, _from, users) do
    {:reply, {:ok, users}, {:ok, users}}
  end

  ## PRIVATE FUNCTIONS
  defp next_user_id(users) do
    max_id = Enum.map(users, fn(user) -> user.id end) |>
      Enum.max(fn() -> 0 end)
    max_id + 1
  end
end
