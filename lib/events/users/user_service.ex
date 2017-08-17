defmodule Users.UserService do
  defstruct users: [], count: 0
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %Users.UserService{})
  end

  def init(state) do
    {:ok, state}
  end

  def new_user(pid, name, email, password) do
    GenServer.call(pid, {:new_user, name, email, password})
  end

  def login(pid, email, password) do
    GenServer.call(pid, {:login, email, password})
  end

  def get_users(pid) do
    GenServer.call(pid, {:get_users})
  end

  #CALLBACKS

  def handle_call({:new_user, name, email, password}, _from, state) do
    user_id = state.count + 1
    {:ok, user} = Users.User.new(name, email, password, user_id)
    state = %{state | users: [user | state.users], count: user_id}
    {:reply, {:ok, user.id}, state}
  end

  def handle_call({:get_users}, _from, users) do
    {:reply, {:ok, users}, {:ok, users}}
  end

  def handle_call({:login, email, password}, _from, state) do
    user = Enum.find(state.users, fn(element) ->
      email == element.email && Users.User.verify_password(password, element.hashed_password)
    end)
    case user do
      nil -> {:reply, {:error, "User not found"}, state}
      user -> {:reply, {:ok, user}, state}
    end
  end
end
