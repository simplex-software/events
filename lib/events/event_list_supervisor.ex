defmodule EventListSupervisor do
  @moduledoc false

    import Supervisor.Spec
    use Supervisor

    def start() do
      children = [supervisor(Events.events_list, [[restart: :trasient]]), worker()]
      opts = [strategy: one_for_one]
      Supervisor.start_link(children, opts)
    end
  
end