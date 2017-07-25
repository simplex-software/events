defmodule ClientSupervisor do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  #ADD client here
  def init(:ok) do
    children = [worker((), [])]
    opts= [strategy: :one_for_one]
    supervise(children, opts)
  end

  def start_child(params) do
    Supervisor.start_child(__MODULE__, params)
  end

  def terminate_child(pid) do
    Supervisor.terminate_child(__MODULE__, pid)
  end

end
