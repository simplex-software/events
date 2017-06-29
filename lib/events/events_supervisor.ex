defmodule EventSupervisor do
  @moduledoc false

    import Supervisor.Spec
    use Supervisor

    def start() do
      children = []
      opts = [strategy: simple_one_for_one, name: events_supervisor]
      Supervisor.start_link(children, opts)
    end
  
end