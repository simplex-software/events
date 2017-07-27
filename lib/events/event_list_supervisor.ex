defmodule Events.EventListSupervisor do
  @moduledoc false

    import Supervisor.Spec
    use Supervisor
    alias Events.EventSupervisor
    alias Events.Notifications.NotificationService
    alias Events.Connection.AutoDiscovery


    def start_link do
        Supervisor.start_link(__MODULE__, :ok)
      end

    def init(:ok) do
      children = [supervisor(EventSupervisor, []),
      worker(NotificationService, []), worker(AutoDiscovery, [])]
      opts = [strategy: :one_for_one]
      supervise(children, opts)

    end

end
