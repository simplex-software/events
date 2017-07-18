defmodule Events.EventSupervisor do

  import Supervisor.Spec
  use Supervisor
  alias Events.Event

  def start_link do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    children = [worker(Event, [])]
    opts = [strategy: :simple_one_for_one]
    supervise(children, opts)
  end

  def start_child(params) do
    Supervisor.start_child(__MODULE__, params)
  end

  def terminate_child(pid) do
    Supervisor.terminate_child(__MODULE__, pid)
  end

end
