defmodule Events.EventListSupervisor do
  @moduledoc false

    import Supervisor.Spec
    use Supervisor
    alias Events.EventSupervisor
    alias Events.Notifications.NotificationService
    alias Events.EventList
    def start_link do
      Supervisor.start_link(__MODULE__, :ok)
    end

    def init(:ok) do
      children = [supervisor(EventSupervisor, []),
      worker(NotificationService, []),
      worker(EventList, [])]
      opts = [strategy: :one_for_one]
      supervise(children, opts)
    end

    def start_child(params) do
      Supervisor.start_child(__MODULE__, params)
    end

    def terminate_child(pid) do
      Supervisor.terminate_child(__MODULE__, pid)
    end
end
