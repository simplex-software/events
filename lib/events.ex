defmodule Events do
  use Application

  def start(_type, _args) do
    Events.EventListSupervisor.start_link()
   end

end
