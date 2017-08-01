defmodule EventListTest do

  use ExUnit.Case
  doctest Events.Event

  test "add new event to eventlist" do
    Events.EventSupervisor.start_link()
    {_, pid} = Events.EventList.start_link
    Events.EventList.add_event(pid, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    assert length(Events.EventList.list_events(pid)) == 1
  end

  test "remove existing event from events list" do
    Events.EventSupervisor.start_link()
    {_, pid} = Events.EventList.start_link
    Events.EventList.add_event(pid, "Title", "decription", ~N[2000-01-01 23:00:07], 320, "user@event.com")
    Events.EventList.remove_event(pid, Enum.at(Events.EventList.list_events(pid), 0))
    assert length(Events.EventList.list_events(pid)) == 0
  end


end
